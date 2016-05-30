class Player implements Drawable{
    
    float x = width/2, y = height/2;
    
    public Player(){
        
    }
    
    boolean collide(Drawable other){
        return false;
    }
    
    void move(){
        
    }
    
    void draw(){
        stroke(127);
        fill(255);
        ellipseMode(RADIUS);
        ellipse(x, y, 10, 10);
    }
    
    void reset(){
        
    }
    
}