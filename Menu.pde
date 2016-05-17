class Menu{
    int subMenu = 0;//0 = main, 1 = howto
    boolean position = false;//0 = play, 1 = howto
    int rectX = 250;
    int rectY = 300;
    
    void draw(){
        if(z_key > 0){
            if(position == true){
                position = false;
                subMenu = 1;
            }else if(position == false){
                gameState = 1;
                reset();
            }
        }
        switch(subMenu){
            case 0:
                drawMenu();
                break;
            case 1:
                drawHowTo();
                break;
        }
        
    }
    
    void drawMenu(){
        //Take key input
        if(up_key == 1){position = false; up_key++;}
        if(down_key == 1){position = true; down_key++;}
        
        //Move that blasted rectangle
        int targetloc = position ? 350 : 300;
        rectY = (int)((rectY + targetloc) / 2 + 3 >= 350 && (rectY + targetloc) / 2 - 3 <= targetloc ? targetloc : (rectY + targetloc) / 2);
        
        //Draw stuff
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Custom Bullet Hell v1",250, 200);
        fill(60, 140, 200);
        rectMode(CENTER);
        rect(rectX, rectY, 100, 50);
        fill(255);
        textSize(20);
        text("Play!", 250, 300);
        textSize(15);
        text("How to?", 250, 350);
        textAlign(LEFT, BOTTOM);
        text("Z to select", 10, 590);
    }
    
    void drawHowTo(){
        fill(255);
        strokeWeight(0);
        
    }
    
    void drawMapSelector(){
        
    }
    
    void reset(){
        subMenu = 0;
        position = false;
        rectY = 300;
    }
    
}
