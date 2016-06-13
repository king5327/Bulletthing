class PauseMenu{
    
    boolean position = false;
    int rectX = width/2 - 50;
    int rectY = 300;
    
    //Um... an exit button and a resume button, I guess.
    
    void draw(){
        if(z_key == 1){
            z_key++;
            if(position == false){
                manager.resume();
                gameState = 2;
                position = false;
            }else if(position == true){
                gameState = 0;
                manager.reset();
                reset();
            }
        }
        if(esc_key == 1){
            println("into the esc branch of pause");
            esc_key++;
            gameState = 2;
            manager.resume();
            position = false;
        }
        drawMenu();
    }
    
    void drawMenu(){
         //Take key input
        if(up_key == 1){position = false; up_key++;}
        if(down_key == 1){position = true; down_key++;}
        
        noStroke();
        fill(0, 0, 0, 127);
        rectMode(CORNERS);
        rect(0, 0, width, height);
        
        //Move that blasted rectangle
        int targetloc = position ? 350 : 300;
        rectY = (int)((rectY + targetloc) / 2 + 3 >= 350 && (rectY + targetloc) / 2 - 3 <= targetloc ? targetloc : (rectY + targetloc) / 2);
        rectX = width/2;
        
        //Draw stuff
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Paused",width/2, 200);
        fill(60, 140, 200);
        rectMode(CENTER);
        rect(rectX, rectY, 100, 50);
        fill(255);
        textSize(20);
        text("Resume", width/2, 300);
        textSize(15);
        text("Exit", width/2, 350);
        textAlign(LEFT, CENTER);
        text("Z to select", rectX + 80, rectY);
    }
    
    void reset(){
        position = false;
        rectX = width/2 - 50;
        rectY = 300;    
    
    }
    
}