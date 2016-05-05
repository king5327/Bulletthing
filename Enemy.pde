public class Enemy extends Timeline implements Drawable {
    boolean destroyOnEscape = true;
    int health = 1;

    public Enemy(String source){
        super(source);
    }

    void draw() {
    }
}

