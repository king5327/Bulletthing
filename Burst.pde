public class Burst extends Timeline implements Templateable {
    float x, y; //Here's where it all begins. Basically a timeline with a position and the ability to be cloned in multiple places.
    Burst linkedBurst = null;
    boolean linked = false;
    
    public Burst(String source){
        super();
    }
    
    @Override
    void readEvents(String source){
        translateEvents(loadStrings("data/burst/" + source + ".txt"));
    }
    
    void spawn(Timeline.Event e){
        
    }
    
}