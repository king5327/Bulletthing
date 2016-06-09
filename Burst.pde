public class Burst extends Timeline implements Templateable {
    float x, y; //Here's where it all begins. Basically a timeline with a position and the ability to be cloned in multiple places.
    Burst linkedBurst = null;
    boolean linked = false;
    
    private Burst(Event e){
    
    x = e.data.containsKey("x") ? Integer.parseInt((String)e.data.get("x")) : 0;
    y = e.data.containsKey("y") ? Integer.parseInt((String)e.data.get("y")) : 0;
        
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
        b.sourceFile = sourceFile;
        b.nextEvent = nextEvent;
        manager.bursts.add(b);
        return b;
    }
    
    Burst spawn(Timeline.Event e, Burst t){
        Burst b = spawn(e);
        
        b.x += t.x;
        b.y += t.y;
        
        return b;
    }

    boolean tick(int time){
        return super.tick(time);
    }
    
}