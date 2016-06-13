public class Enemy extends Bullet { //This didn't make it into the final cut. Mostly because of how there's not enough time to do proper enemies.
    int health = 100;
    boolean killable = true;
    boolean contactable = true;
    
    public Enemy(String source){
        super(source);
    }
    
    @Override
    public void readEvents(String source){
        translateEvents(loadStrings("data/enemy/" + source + ".txt"));
    }

    void draw() {
    }
}