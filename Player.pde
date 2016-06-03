class Player implements Drawable, Collideable{
    
    float x = width/2, y = height/2;
    int grazeRadius = 9, hitRadius = 2;
    int speed = 5, focusSpeed = 1;
    
    public Player(int left, int right, int top, int bottom){
        x = (left + right)/2; y = (bottom + top)*17/20;
    }
    
    boolean collide(Collideable other){ //This is more important than the other ones since it handles both the hit and graze for Player.
        return false;
    }
    
    void move(){
        int v_mode = 0, h_mode = 0;
        if(up_key > 0){
            v_mode += shift_key == 0 ? speed : focusSpeed;
        }
        if(down_key > 0){
            v_mode -= shift_key == 0 ? speed : focusSpeed;
        }
        if(left_key > 0){
            h_mode -= shift_key == 0 ? speed : focusSpeed;
        }
        if(right_key > 0){
            h_mode += shift_key == 0 ? speed : focusSpeed;
        }
        x += h_mode * 60 / frameRate;
        y -= v_mode * 60 / frameRate;
        if(x + hitRadius > right)
            x = right - hitRadius;
        else if(x - hitRadius < left)
            x = left + hitRadius;
        if(y + hitRadius > bottom)
            y = bottom - hitRadius;
        else if(y - hitRadius < top)
            y = top + hitRadius;
    }
    
    void draw(){
        stroke(127, 127, 127, 100);
        fill(255, 255, 255, 200);
        ellipseMode(RADIUS);
        ellipse(x, y, grazeRadius, grazeRadius);
        if(shift_key > 0){
            fill(0);
            noStroke();
            ellipse(x, y, hitRadius, hitRadius);
        }
    }
    
    float getX(){return x;}
    float getY(){return y;}
    float setX(float newX){x = newX; return x;}
    float setY(float newY){y = newY; return y;}
    float getRadius(){return hitRadius;}
    
    
    void collided(){
        Object nil = null;
    }
    
    void reset(){
        
    }
    
}