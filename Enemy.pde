public class Enemy extends Bullet {
    boolean destroyOnEscape = true;
    int health = 1;

    public Enemy(String source){
        super(source);
    }

    void draw() {
    }
}

