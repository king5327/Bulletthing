final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime = -1;
    Event nextEvent = new Event("null");
    boolean over = false;
    int currentTime;
    
    boolean waiting;
    float waitUntil;

    private Timeline(){
        
    }

    public Timeline(String source) {
        sourceFile = source;
        println("sourcefile set to " + sourceFile);
        readEvents(source);
    }
    
    void readEvents(String source){
        //Work out the list of events as read from the file.
        translateEvents(loadStrings("data/timeline/" + source + ".txt"));
        println("data/timeline/" + source + ".txt");
    }
    
    void translateEvents(String[] lines){ //Line by line, add to the chain of events.
        Event position = nextEvent;
        for(String line:lines){
            line = line.trim();
            position.next = translateEvent(line);
            position = position.next;
        }
    }
    
    boolean start(int i){
        startTime = i;
        return true;
    }
    
    Event translateEvent(String line){
        //Then, process the lines into events
        //Always call the superclass's  translateEvent to ensure you don't lose any methods from above, unless it's this top class.
        //Yes, I know some events return null Events (not null pointers of type Event). Luckily, this is built to handle that.
       String[] split = line.split(" ");
       Event e = new Event();
           switch(split[0]){
           case "":
           case "//":
           case "null":
               break;
           case "enemy":
               if(!templates.containsKey("enemy " + split[1]))
                   templates.put("enemy " + split[1], new Enemy(split[1]));
               e.eventType = "enemy";
               e.data.put("type", split[1]);
               Utility.toMap(e.data, Utility.arraySub(split, 2, split.length));
               break;
           case "burst":
               if(!templates.containsKey("burst " + split[1])){
                   templates.put("burst "+split[1], new Burst(split[1]));
               }
               e.eventType = "burst";
               e.data.put("type", split[1]);
               Utility.toMap(e.data, Utility.arraySub(split, 2, split.length));
               break;
           case "bullet": //Literally just copies it into the list, as above. I should handle this better but overall it doesn't matter.
               if(!templates.containsKey("bullet " + split[1])){
                   templates.put("bullet "+split[1], new Bullet(split[1]));
               }
               e.eventType = "bullet"; 
               e.data.put("type", split[1]);
               Utility.toMap(e.data, Utility.arraySub(split, 2, split.length));
               break;
           case "wait":
           case "pause":
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
        return e;
    }
    
    boolean processEvent(Event e, int time){
        //Handles events as they come up in the actual execution of the timeline. The timeline-only process just spawns and waits.
        
        //println(e.eventType);
        switch(e.eventType){
            case "wait":
                waitUntil = time + ((Integer) e.data.get("time")).intValue();
                waiting = true;
                break;
            case "burst":
                ((Burst) templates.get("burst " + (String) e.data.get("type"))).spawn(e);
                break;
            case "bullet":
                ((Bullet) templates.get("bullet " + (String) e.data.get("type"))).spawn(e);
                //println("This code is the timeline bullet spawn");
                break;
            case "enemy":
                ((Enemy) templates.get("enemy  " + (String) e.data.get("type"))).spawn(e);
                break;
            case "end":
                over = true;
                break;
            default:
                break;
        }
        return true;
    }

    boolean tick(int m) {
        //Takes the interval between the current time and the last tick, as provided either from the gamemanager or its subclasses, and ticks itself.
        currentTime += m;
        if(startTime == -1 || over == true){
            return false;
        }else{
            while(over == false){
                if(waiting){
                    if(currentTime > waitUntil){
                        waiting = false;
                    }
                    else{
                        return true;
                    }
                }
                if(processEvent(nextEvent, currentTime)){
                    nextEvent = nextEvent.next;
                    if(nextEvent == null) over = true; //Catch files which didn't end their scripts properly.
                }
            }
            return true;
        }
    }
    
    void interrupt(){
        waiting = false;
    }

    class Event{
        public String eventType = "null"; //null, enemy, burst, bullet, end
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