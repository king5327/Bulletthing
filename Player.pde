class Player implements Drawable, Collideable{
    
    float x = width/2, y = height/2;
    int grazeRadius = 15, hitRadius = 1;
    float speed = 3, focusSpeed = 0.5;
    boolean alive = true;
    
    public Player(){
        x = (left + right)/2; y = (bottom + top)*17/20;
    }
    
    public boolean collide(Collideable other){ //This is more important than the other ones since it handles both the hit and graze for Player.
        //Handles both graze and hit collisions. In theory, the bullet collide should not be called with this, as it only handles hit.
        if(!alive) return false;
        float distances = sqrt((pow(this.x - other.getX(), 2) + pow(this.y - other.getY(), 2)));
        if(hitRadius + other.getRadius() > distances){
            delay(500);
            other.collided();
            collided();
            manager.notifyDead();
            return true;
        }else if(grazeRadius + other.getRadius() > distances && other.getGrazed() == false){
            other.graze();
            this.graze();
            return true;
        }
        return false;
    }
    
    void move(int m){
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
            x += h_mode * m / 30; //Makes movement a function of both speed and time. Any lag should then not change the motions too much.
            y -= v_mode * m / 30;
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
                fill(0,0,0,30);
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
        //println("Dead, jim!");
        z_key = z_key == 1 ? 2 : z_key;
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
        //println("Grazed, jim.");
        window.score++;
    }
    
}