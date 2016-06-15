class Window implements Drawable{
    int left, right, top, bottom;
    int score = 0;
    
    
    public Window(int left, int right, int top, int bottom){
        this.left = left;
        this.right = right;
        this.top = top;
        this.bottom = bottom;
    }
    
    public void draw(){
        
        //This makes the overlay for everything else.
        
        textSize(15);
        
        fill(200, 60, 140);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, left, height);
        rect(left, 0, right, top);
        rect(right, 0, width, height);
        rect(left, bottom, right, height);
        
        //List the score here.
        
        fill(0, 0, 0);
        textAlign(LEFT, TOP);
        text("Score: " + score, 400, 50);
        text("Time: " + nf(((manager.currentTime - manager.startTime)/1000f), 1, 3) + "s", 400, 100);
        
        fill(0);
        textAlign(LEFT, BOTTOM);
        text("Esc to Pause", 5, height-5);
    }
    
    void reset(){
        score = 0;
    }
    
}