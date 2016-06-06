public class Bullet extends Burst implements Drawable, Collideable {
    boolean friendly = false;
    boolean bomb = false;
    boolean destroyOnEscape = true;
    int damage = 0;
    int radius = 10;
    float xspeed = 0, yspeed = 0, xaccel = 0, yaccel = 0, xforce = 0, yforce = 0;
    int lastTime;
    int top, bottom, left, right, wid, hei;
    color center = color(180, 30, 255, 180), ring = color(0, 0, 0, 150);
    boolean grazed = false;
    boolean alive = true;
    
    public Bullet(String source){
        super(source);
    }
    
    void spawn(Timeline.Event e){ //Basically, a non-ticked version of this enemy can be defined too for easy cloning.
        
    }
    
    @Override
    void readEvents(String source){
        translateEvents(loadStrings("data/bullet/" + source + ".txt"));
    }
    
    boolean tick(int time){
        
        //DoStuff
        lastTime = time;
        x += xspeed * time/1000;
        y += yspeed * time/1000;
        xspeed += xaccel * time/1000;
        yspeed += yaccel * time/1000;
        xaccel += xforce * time/1000;
        yaccel += yforce * time/1000;
        
        if(((x + wid < left || x > right) || (y + hei < top || y > bottom)) && destroyOnEscape || !alive){
            return false;
        }
        return true;
    }

    void draw() {
        ellipseMode(RADIUS);
        fill(center);
        stroke(ring);
        ellipse(50, 50, 30, 30);
    }
    
    boolean collide(Collideable other){
        if(radius + other.getRadius() < pow(pow(x - other.getX(), 2) + pow(y - other.getY(), 2),1/2)){
            other.collided();
            return true;
        }
        return false;
    }
    
    float getX(){return x;}
    float getY(){return y;}
    float setX(float newX){x = newX; return x;}
    float setY(float newY){y = newY; return y;}
    float getRadius(){return radius;};
    
    void collided(){
        alive = false;
    }
}