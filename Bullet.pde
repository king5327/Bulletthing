public class Bullet extends Burst implements Drawable, Collideable {
    boolean friendly = false;
    boolean bomb = false;
    boolean destroyOnEscape = true;
    int damage = -1; //Negative ones hit player. Positive ones hit enemies, if I get them implemented.
    float radius = 2.5;
    float xspeed = 0, yspeed = 0, xaccel = 0, yaccel = 0, xforce = 0, yforce = 0;
    int wid = 5, hei = 5, wegt = 0; //Width, Height, Stroke Weight
    int cr = 180, cg = 30, cb = 255, ca = 180;
    int rr = 0, rg = 0, rb = 0, ra = 150;
    color center = color(cr, cg, cb, ca), ring = color(rr, rg, rb, ra);
    public boolean grazed = false;
    boolean alive = true;
    
    private Bullet(Event e){
    super(e);
    readData(e);
    println("spawned bullet with " + xspeed + " " + yspeed);
    center = color(cr, cg, cb, ca); ring = color(rr, rg, rb, ra);
    }//For actual spawning;
    
    private void readData(Event e){ //Lots of variables to have read from the file.
    xspeed = e.data.containsKey("xs") ? Float.parseFloat((String)e.data.get("xs"))       : xspeed;
    yspeed = e.data.containsKey("ys") ? Float.parseFloat((String)e.data.get("ys"))       : yspeed;
    xaccel = e.data.containsKey("xa") ? Float.parseFloat((String)e.data.get("xa"))       : xaccel;
    yaccel = e.data.containsKey("ya") ? Float.parseFloat((String)e.data.get("ya"))       : yaccel;
    xforce = e.data.containsKey("xf") ? Float.parseFloat((String)e.data.get("xf"))       : xforce;
    yforce = e.data.containsKey("yf") ? Float.parseFloat((String)e.data.get("yf"))       : yforce;
    radius = e.data.containsKey("r")  ? Float.parseFloat((String)e.data.get("r"))        : radius;
    
    wid = e.data.containsKey("w")     ? (int) Float.parseFloat((String)e.data.get("w"))  : wid;
    hei = e.data.containsKey("h")     ? (int) Float.parseFloat((String)e.data.get("h"))  : hei;
    wegt = e.data.containsKey("sw")   ? (int) Float.parseFloat((String)e.data.get("sw")) : wegt;
    
    cr = e.data.containsKey("cr")     ? (int) Float.parseFloat((String)e.data.get("cr")) : cr; //Color changing
    cg = e.data.containsKey("cg")     ? (int) Float.parseFloat((String)e.data.get("cg")) : cg;
    cb = e.data.containsKey("cb")     ? (int) Float.parseFloat((String)e.data.get("cb")) : cb;
    ca = e.data.containsKey("ca")     ? (int) Float.parseFloat((String)e.data.get("ca")) : ca;
    
    rr = e.data.containsKey("rr")     ? (int) Float.parseFloat((String)e.data.get("rr")) : rr;
    rg = e.data.containsKey("rg")     ? (int) Float.parseFloat((String)e.data.get("rg")) : rb;
    rb = e.data.containsKey("rb")     ? (int) Float.parseFloat((String)e.data.get("rb")) : rg;
    ra = e.data.containsKey("ra")     ? (int) Float.parseFloat((String)e.data.get("ra")) : ra;
    
    destroyOnEscape = e.data.containsKey("osd") ? !"false".equalsIgnoreCase((String)e.data.get("osd")) : destroyOnEscape;
    
    center = color(cr, cg, cb, ca);
    ring = color(rr, rg, rb, ra);
    
    super.readData(e);
    
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
        x += xspeed * time/100;
        y += yspeed * time/100;
        xspeed += xaccel * time/100;
        yspeed += yaccel * time/100;
        xaccel += xforce * time/100;
        yaccel += yforce * time/100;
        //println("bullet ticked with time " + time + ", start " + startTime);
        //println("x,y " + x + "," + y);
        
        if((((x + wid/2 < left || x - wid/2 > right) || (y + hei/2 < top || y - hei/2 > bottom)) && (destroyOnEscape || over)) || !alive){
            //println("bullet deleted out of bounds alive is " + alive);
            return false;
        }
        if(xspeed == 0 && yspeed == 0 && xaccel == 0 && yaccel == 0 && xforce == 0 && yforce == 0 && over){
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
        ellipseMode(CENTER);
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
    
    
    
    public float getX(){return x;}
    public float getY(){return y;}
    public float setX(float newX){x = newX; return x;}
    public float setY(float newY){y = newY; return y;}
    public float getRadius(){return radius;};
    
    void collided(){
        alive = false;
    }
    
    void graze(){
        grazed = true;
    }
    
    boolean getGrazed(){return grazed;}
}