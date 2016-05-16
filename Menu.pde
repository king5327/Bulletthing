class Menu{
    int subMenu = 0;//0 = main, 1 = howto, 2 = selector
    boolean position = false;//0 = play, 1 = howto
    int rectX = 200;
    int rectY = 275;
    
    void draw(){
        drawMenu();
        
    }
    
    void drawMenu(){
        //Take key input
        if(up_key == 1){position = false; up_key++;}
        if(down_key == 1){position = true; down_key++;}
        
        //Move that blasted rectangle
        if(position){
            rectY = (int)(rectX + 350 / 2 <= 200 ? 200 : (rectX + 200) / 2 + 10);
        }else{
            rectY = (int)(rectX + 350 / 2 >= 300 ? 300 : (rectX + 300) / 2 - 10);
        }
        
        //Draw stuff
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Custom Bullet Hell v1",250, 200);
        fill(60, 140, 200);
        rect(rectX, rectY, 100, 50);
        fill(255);
        textSize(20);
        text("Play!", 250, 300);
        textSize(15);
        text("How to?", 250, 350);
    }
    
    void drawHowTo(){
        
    }
    
    void drawMapSelector(){
        
    }
    
    void reset(){
        subMenu = 0;
        position = false;
    }
    
}
