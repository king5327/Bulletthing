final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime;
    Event nextEvent = new Event("null");
    boolean over = false;
    
    boolean waiting;
    float waitUntil;

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
               case "null":
                   break;
               case "enemy":
                   if(!templates.containsKey("enemy " + split[1]))
                       templates.put("enemy " + split[1], new Enemy(split[1]));
                   e.eventType = "enemy";
                   e.datum = Utility.arraySub(split, 1, split.length);
                   break;
               case "burst":
                   if(!templates.containsKey("burst " + split[1])){
                       templates.put("burst "+split[1], new Burst(split[1]));
                   }
                   e.eventType = "burst";
                   e.datum = Utility.arraySub(split, 1, split.length);
                   break;
               case "bullet": //Literally just copies it into the list, as above. I should handle this better but overall it doesn't matter.
                   if(!templates.containsKey("bullet " + split[1])){
                       templates.put("bullet "+split[1], new Bullet(split[1]));
                   }
                   e.eventType = "bullet";
                   e.datum = Utility.arraySub(split, 1, split.length);
                   break;
               case "wait":
                   e.eventType = "wait";
                   e.data.put("time", new Integer(Integer.parseInt(split[1])));
                   break;
               case "end":
               case "finish":
               case "stop":
                   e.eventType = "end";
                   break;
               default:
                   break;
           }
        }
        return e;
    }
    
    boolean processEvent(Event e, int time){
        switch(e.eventType){
            case "wait":
                waitUntil = time + waitUntil;
                waiting = true;
                break;
            case "burst":
                templates.get("burst " + e.datum[0]);
            default:
                break;
        }
        return true;
    }

    boolean tick(int m) {
        if(startTime == 0 || over == true){
            return false;
        }else{
            if(waiting){
                if(m > waitUntil){
                    waiting = false;
                }
                else{
                    return true;
                }
            }
            if(processEvent(nextEvent, m)){
                nextEvent = nextEvent.next;
            }
            return true;
        }
    }
    
    void interrupt(){
        waiting = false;
    }

    class Event{
        public String eventType = "null"; //0 is null, 1 is enemy, 2 is burst, 3 is bullet, 4 is end
        public String[] datum; //In other words, if string or complex data ever needs moving. Will be obsoleted by data eventually;
        public HashMap data = new HashMap<Object, Object>();
        public Event next = null; //Next event, one way linked-list style. No need to ever go back, so leave the old ones to garbage collection
        public Event(){
        }
        public Event(String eventType){
            this.eventType = eventType;
        }
    }
}