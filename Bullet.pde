public class Bullet extends Timeline implements Drawable, Templateable {
    boolean friendly = false;
    int damage = 0;
    int radius = 10;
    float xspeed = 0, yspeed = 0;
    int lastTime;
    int x, y, top, bottom, left, right, wid, hei;
    color c = color(180, 30, 255, 180);

    public Bullet(String source){
        super(source);
    }
    
    void spawn(int x, int y, int top, int bottom, int left, int right){ //Basically, a non-ticked version of this enemy can be defined too for easy cloning.
        
    }
    
    boolean tick(int time){
        
        //DoStuff
        lastTime = time;
        
        if((x + wid < left || x > right) || (y + hei < top || y > bottom)){
            return false;
        }
        return true;
    }

    void draw() {
        ellipseMode(RADIUS);
        fill(c);
        ellipse(50, 50, 30, 30);
    }
}

