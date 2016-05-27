class Player implements Drawable{
    
    float x, y;
    
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