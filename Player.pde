class Player implements Drawable, Collideable{
    
    float x = width/2, y = height/2;
    int grazeRadius = 15, hitRadius = 2;
    float speed = 2, focusSpeed = 0.5;
    boolean alive = true;
    
    public Player(){
        x = (left + right)/2; y = (bottom + top)*17/20;
    }
    
    public boolean collide(Collideable other){ //This is more important than the other ones since it handles both the hit and graze for Player.
        if(!alive) return false;
        float distances = sqrt((pow(this.x - other.getX(), 2) + pow(this.y - other.getY(), 2)));
        if(hitRadius + other.getRadius() >= distances){
            other.collided();
            collided();
            manager.notifyDead();
            return true;
        }else if(grazeRadius + other.getRadius() >= distances && other.getGrazed() == false){
            other.graze();
            this.graze();
            return true;
        }
        return false;
    }
    
    void move(){
        if(!manager.paused){
            float v_mode = 0, h_mode = 0;
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
    }
    
    void draw(){
        if(alive){
            stroke(127, 127, 127, 100);
            fill(255, 255, 255, 200);
            ellipseMode(RADIUS);
            strokeWeight(0);
            //ellipse(x, y, grazeRadius, grazeRadius);
            if(shift_key > 0){
                fill(0);
            }else{
                fill(0,0,0,15);
            }
            noStroke();
            ellipse(x, y, hitRadius, hitRadius);
        }
    }
    
    void drawUnder(){
        if(alive){
            stroke(127, 127, 127, 100);
            fill(255, 255, 255, 200);
            ellipseMode(RADIUS);
            strokeWeight(0);
            ellipse(x, y, grazeRadius, grazeRadius);
        }
    }
    
    public float getX(){return x;}
    public float getY(){return y;} //Collideable implementation. Pretty much a copypaste.
    public float setX(float newX){x = newX; return x;}
    public float setY(float newY){y = newY; return y;}
    public float getRadius(){return hitRadius;}
    
    
    public void collided(){
        println("Dead, jim!");
        alive = false;
        manager.notifyDead();
    }
    
    void reset(){
        x = (left + right)/2; y = (bottom + top)*17/20;
        alive = true;
    }
    
    public boolean getGrazed(){
        return false;
    }
    
    public void graze(){
        println("Grazed, jim.");
        window.score++;
    }
    
}