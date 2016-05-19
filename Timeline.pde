final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime;
    Event nextEvent = new Event(0);
    static HashMap templates = new HashMap();

    public Timeline(String source) {
        sourceFile = source;
        readEvent = 
    }
    
    public readEvents(String source){
        //Work out the list of events as read from the file.
    }
    
    public translateEvent(String source){
        //Then, process the lines into events
    }
    
    Event processEvent(Event e){
        //Finally, handle the events. Should always super.processEvent(e) as a default case.
    }

    boolean tick(float m) {
        if(startTime == 0){
            return false; //Don't run an uninitialized timeline.
        }else{
            return true;
        }
    }

    class Event{
        public int eventType = 0; //0 is null, 1 is add, 2 is enemy, 3 is burst, 4 is bullet, 5 is end
        public String[] datum; //In other words, if string or complex data ever needs moving.
        public int[] extraArgs; //For those pesky extra arguments that go around so often.
        public Event e = null; //Next event, one way linked-list style. No need to ever go back, so leave the old ones to garbage collection
        public Event(){
        }
        public Event(int eventType){
            this.eventType = eventType;
        }
    }
}

