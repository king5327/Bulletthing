class Player implements Drawable{
    
    float x, y, radius;
    
    
    boolean collide(Drawable other){
        if(Math.pow(Math.pow(x - other.getX(), 2) + Math.pow(y - other.getY(), 2), 1/2) < radius + other.getRadius())
            return true;
        return false;
    }
    
    void draw(){
        
    }
    
    void reset(){
        
    }
    
    float getX(){return x;}
    float getY(){return y;}
    float getRadius(){return radius;}
    
}