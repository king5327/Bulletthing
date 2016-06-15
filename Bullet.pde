public class Bullet extends Burst implements Drawable, Collideable {
    boolean friendly = false;
    boolean bomb = false;
    boolean destroyOnEscape = true;
    int damage = -1; //Negative ones hit player. Positive ones hit enemies, if I get them implemented.
    float radius = 2.5;
    float xspeed = 0, yspeed = 0, xaccel = 0, yaccel = 0, xforce = 0, yforce = 0;
    int wid = 5, hei = 5, wegt = 0; //Width, Height, Stroke Weight
    int cr = 180, cg = 70, cb = 255, ca = 150;
    int rr = 0, rg = 0, rb = 0, ra = 150;
    color center = color(cr, cg, cb, ca), ring = color(rr, rg, rb, ra);
    public boolean grazed = false;
    boolean alive = true;
    
    private Bullet(Event e){
    super(e);
    readData(e);
    //println("spawned bullet with " + xspeed + " " + yspeed);
    }//For actual spawning;
    
    private void readData(Event e){ //Lots of variables to have read from the file.
    //Done to be as efficient as possible, but the checks still all happen on spawn and change.
    
    super.readData(e);
    
    if(e.data.containsKey("xs")) xspeed = Float.parseFloat((String)e.data.get("xs"));
    if(e.data.containsKey("ys")) yspeed = Float.parseFloat((String)e.data.get("ys"));
    if(e.data.containsKey("xa")) xaccel = Float.parseFloat((String)e.data.get("xa"));
    if(e.data.containsKey("ya")) yaccel = Float.parseFloat((String)e.data.get("ya"));
    if(e.data.containsKey("xf")) xforce = Float.parseFloat((String)e.data.get("xf"));
    if(e.data.containsKey("yf")) yforce = Float.parseFloat((String)e.data.get("yf"));
    if(e.data.containsKey("r"))  radius = Float.parseFloat((String)e.data.get("r"));
    
    if(e.data.containsKey("w"))     wid = (int) Float.parseFloat((String)e.data.get("w"));
    if(e.data.containsKey("h"))     hei = (int) Float.parseFloat((String)e.data.get("h"));
    if(e.data.containsKey("sw"))   wegt = (int) Float.parseFloat((String)e.data.get("sw"));
    
    if(e.data.containsKey("cr"))     cr = (int) Float.parseFloat((String)e.data.get("cr")); //Color changing
    if(e.data.containsKey("cg"))     cg = (int) Float.parseFloat((String)e.data.get("cg"));
    if(e.data.containsKey("cb"))     cb = (int) Float.parseFloat((String)e.data.get("cb"));
    if(e.data.containsKey("ca"))     ca = (int) Float.parseFloat((String)e.data.get("ca"));
    
    if(e.data.containsKey("rr"))     rr = (int) Float.parseFloat((String)e.data.get("rr"));
    if(e.data.containsKey("rg"))     rg = (int) Float.parseFloat((String)e.data.get("rg"));
    if(e.data.containsKey("rb"))     rb = (int) Float.parseFloat((String)e.data.get("rb"));
    if(e.data.containsKey("ra"))     ra = (int) Float.parseFloat((String)e.data.get("ra"));
    
    if(e.data.containsKey("osd")) destroyOnEscape = "false".equalsIgnoreCase((String)e.data.get("osd"));
    
    center = color(cr, cg, cb, ca);
    ring = color(rr, rg, rb, ra);
    //println("changed states");
    
    }
    
    public Bullet(String source){
        super(source);
    }
    
    @Override
    public Bullet spawn(Timeline.Event e){
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
                break;
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