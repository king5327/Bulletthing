final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;
    int startTime;
    ArrayList events = new ArrayList<Event>();

    public Timeline(String source) {
        sourceFile = source;
    }
    

    boolean tick(float m) {
        if(startTime == null){
            return false; //Don't run an uninitialized timeline.
        }else{
            return true;
        }
    }

    class Event{
        public int eventType = 0; //0 is null, 1 is add, 2 is enemy, 3 is burst, 4 is bullet
        public String[] datum; //In other words, if string or complex data ever needs moving.
        public int[] extraArgs; //For those pesky extra arguments that go around so often.
        public Event e = null; //Next event, one way linked-list style. No need to ever go back, so leave the old ones to garbage collection
    }
}

