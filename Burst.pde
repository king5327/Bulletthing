public class Burst extends Timeline implements Templateable {
    float x, y; //Here's where it all begins. Basically a timeline with a position and the ability to be cloned in multiple places.
    Burst linkedBurst = null;
    boolean linked = false;
    
    private Burst(Event e){
    
    x = e.data.containsKey("x") ? Float.parseFloat((String)e.data.get("x")) : 0;
    y = e.data.containsKey("y") ? Float.parseFloat((String)e.data.get("y")) : 0;
    println("spawned burst with " + x + " " + y);    
        
    }//For actual spawning;
    
    public Burst(String source){
        super(source);
    }
    
    @Override
    public void readEvents(String source){
        translateEvents(loadStrings("data/burst/" + source + ".txt"));
        println("data/burst/" + source + ".txt");
    }
    
    @Override
    public Event translateEvent(String line){
       String[] split = line.split(" ");
       Event e = new Event();
       switch(split[0]){
           default:
               return super.translateEvent(line);
       }
    }
    
    Burst spawn(Timeline.Event e){
        Burst b = new Burst(e);
        b.sourceFile = this.sourceFile;
        b.nextEvent = nextEvent;
        manager.bursts.add(b);
        b.startTime = manager.currentTime;
        println("New burst " + b.sourceFile + " spawned by " + sourceFile);
        return b;
    }
    
    Burst spawn(Timeline.Event e, Burst t){
        Burst b = spawn(e);
        
        b.x += t.x;
        b.y += t.y;
        
        return b;
    }
    
    @Override
    public boolean processEvent(Event e, int time){
        //println(e.eventType);
        switch(e.eventType){
            case "wait":
                waitUntil = time + ((Integer) e.data.get("time")).intValue();
                waiting = true;
                break;
            case "burst":
                ((Burst) templates.get("burst " + (String) e.data.get("type"))).spawn(e, this);
                break;
            case "bullet":
                ((Bullet) templates.get("bullet " + (String) e.data.get("type"))).spawn(e, this);
                //println("This code is the timeline bullet spawn");
                break;
            case "enemy":
                ((Enemy) templates.get("enemy " + (String) e.data.get("type"))).spawn(e, this);
                break;
            case "end":
                over = true;
                break;
            default:
                break;
        }
        return true;
    }

    boolean tick(int time){
        return super.tick(time);
    }
    
}