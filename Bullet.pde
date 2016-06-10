public class Bullet extends Burst implements Drawable, Collideable {
    boolean friendly = false;
    boolean bomb = false;
    boolean destroyOnEscape = true;
    int damage = 0;
    float radius = 2.5;
    float xspeed = 0, yspeed = 0, xaccel = 0, yaccel = 0, xforce = 0, yforce = 0;
    int wid = 5, hei = 5, wegt = 0;
    int cr = 180, cg = 30, cb = 255, ca = 180;
    int rr = 0, rg = 0, rb = 0, ra = 150;
    color center = color(cr, cg, cb, ca), ring = color(rr, rg, rb, ra);
    boolean grazed = false;
    boolean alive = true;
    
    private Bullet(Event e){
    super(e);
    readData(e);
    println("spawned bullet with " + xspeed + " " + yspeed);
    center = color(cr, cg, cb, ca); ring = color(rr, rg, rb, ra);
    }//For actual spawning;
    
    public void readData(Event e){
    xspeed = e.data.containsKey("xs") ? Float.parseFloat((String)e.data.get("xs")) : 0;
    yspeed = e.data.containsKey("ys") ? Float.parseFloat((String)e.data.get("ys")) : 0;
    xaccel = e.data.containsKey("xa") ? Float.parseFloat((String)e.data.get("xa")) : 0;
    yaccel = e.data.containsKey("ya") ? Float.parseFloat((String)e.data.get("ya")) : 0;
    xforce = e.data.containsKey("xf") ? Float.parseFloat((String)e.data.get("xf")) : 0;
    yforce = e.data.containsKey("yf") ? Float.parseFloat((String)e.data.get("yf")) : 0;
    radius = e.data.containsKey("r") ? Float.parseFloat((String)e.data.get("r")) : 10;
    wid = e.data.containsKey("w") ? (int) Float.parseFloat((String)e.data.get("w")) : 5;
    hei = e.data.containsKey("h") ? (int) Float.parseFloat((String)e.data.get("h")) : 5;
    wegt = e.data.containsKey("sw") ? (int) Float.parseFloat((String)e.data.get("sw")) : wegt;
    
    cr = e.data.containsKey("cr") ? (int) Float.parseFloat((String)e.data.get("cr")) : cr; //Color changing
    cg = e.data.containsKey("cg") ? (int) Float.parseFloat((String)e.data.get("cg")) : cg;
    cb = e.data.containsKey("cb") ? (int) Float.parseFloat((String)e.data.get("cb")) : cb;
    ca = e.data.containsKey("ca") ? (int) Float.parseFloat((String)e.data.get("ca")) : ca;
    
    rr = e.data.containsKey("rr") ? (int) Float.parseFloat((String)e.data.get("rr")) : rr;
    rg = e.data.containsKey("rg") ? (int) Float.parseFloat((String)e.data.get("rg")) : rb;
    rb = e.data.containsKey("rb") ? (int) Float.parseFloat((String)e.data.get("rb")) : rg;
    ra = e.data.containsKey("ra") ? (int) Float.parseFloat((String)e.data.get("ra")) : ra;
    
    center = color(cr, cg, cb, ca);
    ring = color(rr, rg, rb, ra);
    
    }
    
    public Bullet(String source){
        super(source);
    }
    
    Bullet spawn(Timeline.Event e){
        Bullet b = new Bullet(e);
        b.sourceFile = sourceFile;
        b.nextEvent = nextEvent;
        manager.bullets.add(b);
        b.startTime = manager.currentTime;
        return b;
    }
    
    Bullet spawn(Timeline.Event e, Burst t){
        Bullet b = spawn(e);
        
        b.x += t.x;
        b.y += t.y;
        
        return b;
    }
    
    @Override
    public void readEvents(String source){
        translateEvents(loadStrings("data/bullet/" + source + ".txt"));
        println("data/bullet/" + source + ".txt");
    }
    
    boolean tick(int time){
        
        //DoStuff
        lastTime = time;
        x += xspeed * time/100000;
        y += yspeed * time/100000;
        xspeed += xaccel * time/1000;
        yspeed += yaccel * time/1000;
        xaccel += xforce * time/1000;
        yaccel += yforce * time/1000;
        //println("bullet ticked with time " + time + ", start " + startTime);
        //println("x,y " + x + "," + y);
        
        if(((x + wid/2 < left || x - wid/2 > right) || (y + hei/2 < top || y - hei/2 > bottom)) && destroyOnEscape || !alive){
            //println("bullet deleted out of bounds alive is " + alive);
            return false;
        }
        super.tick(time);
        return true;
        
    }
    
    Event translateEvent(String line){
        //Then, process the lines into events
        //Always call the superclass's  translateEvent to ensure you don't lose any methods from above, unless it's this top class.
       String[] split = line.split(" ");
       Event e = new Event();
           switch(split[0]){
           
           case "kill":
           case "suicide":
           case "dead":
               e.eventType = "kill";
               break;
           case "change":
           case "set":
               e.eventType = "change";
               Utility.toMap(e.data, Utility.arraySub(split, 1, split.length));
               break;
           default:
               e = super.translateEvent(line);
               break;
       }
        return e;
    }
    
    @Override
    public boolean processEvent(Event e, int time){
        //println(e.eventType);
        //print(e.eventType);
        switch(e.eventType){
            case "kill":
                alive = false;
                break;
            case "change":
                readData(e);
            default:
                super.processEvent(e, time);
                break;
        }
        return true;
    }

    void draw() {
        ellipseMode(RADIUS);
        fill(center);
        stroke(ring);
        strokeWeight(wegt);
        ellipse(x, y, wid, hei);
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