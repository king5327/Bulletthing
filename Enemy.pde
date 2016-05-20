public class Enemy extends Bullet {
    int health = 100;
    boolean killable = true;
    boolean contactable = true;
    
    @Override
    void readEvents(String source){
        translateEvents(loadStrings("data/enemy/" + source + ".txt"));
    }

    void draw() {
    }
}
