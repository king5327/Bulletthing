public class Bullet extends Burst implements Drawable {
    boolean friendly = false;
    boolean bomb = false;
    boolean destroyOnEscape = true;
    int damage = 0;
    int radius = 10;
    float xspeed = 0, yspeed = 0, xaccel = 0, yaccel = 0, xforce = 0, yforce = 0;
    int lastTime;
    int top, bottom, left, right, wid, hei;
    color center = color(180, 30, 255, 180), ring = color(0, 0, 0, 150);
    
    //Event extra types: 10 is change x, 

    public Bullet(String source){
        super(source);
    }
    
    void spawn(int x, int y, int top, int bottom, int left, int right){ //Basically, a non-ticked version of this enemy can be defined too for easy cloning.
        
    }
    
    boolean tick(int time){
        
        //DoStuff
        lastTime = time;
        x += xspeed * time/1000;
        y += yspeed * time/1000;
        
        if(((x + wid < left || x > right) || (y + hei < top || y > bottom)) && destroyOnEscape){
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

