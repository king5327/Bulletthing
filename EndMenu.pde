class EndMenu{
    
    //Um... an exit button and a resume button, I guess.
    
    void draw(){
        if(z_key == 1){
            z_key++;
            gameState = 0;
            manager.reset();
        }
        if(gameState == 4){
            drawFail();
        }else if(gameState == 5){
            drawPass();
        }
        
    }
    
    void drawFail(){
        
        //Draw stuff
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Game Over",width/2, 200);
        text("You have been slain by the Bullets", width/2, 300);
        textSize(15);
        text("You survived " + (manager.currentTime - manager.startTime)/1000f + "s\nYour score: " + window.score, width/2, 350);
        textAlign(LEFT, BOTTOM);
        text("Z to return to the menu", 10, height-10);
    }
    
    void drawPass(){
        //Draw stuff
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Game Over",width/2, 200);
        text("You survived the entire round!", width/2, 300);
        textSize(15);
        text("Your score: " + window.score, width/2, 350);
        textAlign(LEFT, BOTTOM);
        text("Z to return to the menu", 10, height-10);
        
    }
    
}