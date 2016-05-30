class Window implements Drawable{
    int left, right, top, bottom;
    
    
    public Window(int left, int right, int top, int bottom){
        this.left = left;
        this.right = right;
        this.top = top;
        this.bottom = bottom;
    }
    
    void draw(){
        fill(200, 60, 140);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, left, height);
        rect(left, 0, right, top);
        rect(right, 0, width, height);
        rect(left, bottom, right, height);
    }
    
}