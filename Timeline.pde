final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime;
    Event nextEvent = new Event("null");
    boolean over = false;

    private Timeline(){
        
    }

    public Timeline(String source) {
        sourceFile = source;
        readEvents(source);
    }
    
    void readEvents(String source){
        //Work out the list of events as read from the file.
        translateEvents(loadStrings("data/timeline/" + source + ".txt"));
    }
    
    void translateEvents(String[] lines){
        Event position = nextEvent;
        for(String line:lines){
            line = line.trim();
            println(line);
            position.next = translateEvent(line);
            position = position.next;
        }
    }
    
    Event translateEvent(String line){
        //Then, process the lines into events
        //Always call the superclass's  translateEvent to ensure you don't lose any methods from above, unless it's this top class.
       String[] split = line.split(" ");
       Event e = new Event();
       if(split.length != 0){
               switch(split[0]){
               case "":
               case "//":
                   break;
               case "enemy":
                   if(!templates.containsKey("enemy " + split[1]))
                       templates.put("enemy " + split[1], new Enemy(split[1]));
                   e.eventType = "enemy";
                   e.datum = Utility.arraySub(split, 1, split.length);
                   break;
               case "burst":
                   break;
               case "bullet":
                   if(!templates.containsKey("bullet " + split[1])){
                       templates.put("bullet "+split[1], new Bullet(split[1]));
                   }
                   break;
               case "wait":
                   break;
               case "end":
                   break;
               default:
                   break;
           }
        }
        return e;
    }
    
    void processEvent(Event e){
        //Finally, handle the events. Should always super.processEvent(e) as a default case, except this is the top class.
    }

    boolean tick(float m) {
        if(startTime == 0 || over == true){
            return false; //Don't run an uninitialized timeline.
        }else{
            processEvent(nextEvent);
            return true;
        }
    }

    class Event{
        public String eventType = "null"; //0 is null, 1 is enemy, 2 is burst, 3 is bullet, 4 is end
        public String[] datum; //In other words, if string or complex data ever needs moving.
        public Event next = null; //Next event, one way linked-list style. No need to ever go back, so leave the old ones to garbage collection
        public Event(){
        }
        public Event(String eventType){
            this.eventType = eventType;
        }
    }
}