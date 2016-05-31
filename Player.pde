class Player implements Drawable{
    
    float x = width/2, y = height/2;
    int grazeRadius = 15, hitRadius = 2;
    
    public Player(){
        
    }
    
    boolean collide(Drawable other){
        return false;
    }
    
    void move(){
        int v_mode = 0, h_mode = 0;
        if(up_key > 0){
            v_mode += shift_key == 0 ? 5 : 1;
        }
        if(down_key > 0){
            v_mode -= shift_key == 0 ? 5 : 1;
        }
        if(left_key > 0){
            h_mode -= shift_key == 0 ? 5 : 1;
        }
        if(right_key > 0){
            h_mode += shift_key == 0 ? 5 : 1;
        }
        x += h_mode * 60 / frameRate;
        y -= v_mode * 60 / frameRate;
    }
    
    void draw(){
        stroke(127, 127, 127, 100);
        fill(255, 255, 255, 200);
        ellipseMode(RADIUS);
        ellipse(x, y, 15, 15);
        if(shift_key > 0){
            fill(0);
            noStroke();
            ellipse(x, y, 2, 2);
        }
    }
    
    void reset(){
        
    }
    
}