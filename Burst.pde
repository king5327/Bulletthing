public class Burst extends Timeline implements Templateable {
    float x, y;
    Burst linkedBurst = null;
    boolean linked = false;
    
    //@Override
    private void readEvents(String source){
        translateEvents(loadStrings("data/burst/" + source + ".txt"));
    }
    
    void spawn(int x, int y, int top, int bottom, int left, int right){
        
    }
    
}

