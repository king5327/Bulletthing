final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime;
    Event nextEvent = new Event("null");
    boolean over = false;

    private Timeline(){
        //Empty
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
            position.next = translateEvent(line);
            position = position.next;
        }
    }
    
    private Event translateEvent(String line){
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
                   e = new Event("enemy");
                   e.datum = new String[3]; e.datum[0] = split[1]; e.datum[1] = split[2]; e.datum[2] = split[4];
                   e.extraArgs = new int[2]; e.extraArgs[0] = Integer.parseInt(split[3]); e.extraArgs[1] = Integer.parseInt(split[4]);
                   break;
               case "burst":
                   break;
               case "bullet":
                   if(!templates.containsKey("bullet " + split[1])){
                       templates.put("bullet "+split[1], new Bullet(split[1]));
                   }
                   break;
               case "wait":
                   e = new Event("wait");
                   break;
               case "end":
                   break;
               default:
                   break;
           }
        }
        return e;
    }
    
    private void processEvent(Event e){
        switch(nextEvent.eventType){
            case "enemy":
        }
    }

    boolean tick(float m) {
        if(startTime == 0 || over){
            return false; //Don't run an uninitialized timeline.
        }else{
            return true;
        }
    }

    class Event{
        public String eventType = "null"; //0 is null, 1 is enemy, 2 is burst, 3 is bullet, 4 is end
        public String[] datum; //In other words, if string or complex data ever needs moving.
        public int[] extraArgs; //For those pesky extra arguments that go around so often.
        public Event next = null; //Next event, one way linked-list style. No need to ever go back, so leave the old ones to garbage collection
        public Event(){
        }
        public Event(String eventType){
            this.eventType = eventType;
        }
    }
}