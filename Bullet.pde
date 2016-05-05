public class Bullet extends Timeline implements Drawable {
    boolean friendly = false;
    int damage = 0;
    int radius = 10;

    public Bullet(String source){
        super(source);
    }

    void draw() {
    }
}

