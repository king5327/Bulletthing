class Menu{
    int subMenu = 0;//0 = main, 1 = howto
    boolean position = false;//0 = play, 1 = howto
    int rectX = width/2 - 50;
    int rectY = 300;
    boolean won, scored;
    float bestScoreTime, bestTime;
    int bestTimeScore, bestScore, bestWinScore;
    String scoreLines;
    
    void draw(){
        if(z_key == 1){
            if(position == true){
                position = false;
                subMenu = 1;
            }else if(position == false){
                gameState = 1;
                reset();
            }
            z_key++;
        }
        if(esc_key == 1){
            esc_key++;
            exit();
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
        rectX = width/2;
        
        //Draw stuff
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        text("Custom Bullet Hell v1",width/2, 200);
        fill(60, 140, 200);
        rectMode(CENTER);
        rect(rectX, rectY, 100, 50);
        fill(255);
        textSize(20);
        text("Play!", width/2, 300);
        textSize(15);
        text("How to?", width/2, 350);
        textAlign(LEFT, BOTTOM);
        text("Z to select", 10, height-10);
        
        textSize(10);
        scoreLines = "";
        if(scored){
            scoreLines += bestTime + " - Best Non-Winning Time\n";
            scoreLines += bestTimeScore + " - Best Non-Winning Time's Score\n\n";
            scoreLines += bestScore + " - Best Non-Winning Score\n";
            scoreLines += bestScoreTime + " - Best Non-Winning Score's Time";
        }
        if(won && scored){
            scoreLines += "\n>====================<\n";
        }
        if(won){
            scoreLines += bestWinScore + " - Best Winning Score";
        }
        
        textSize(12);
        textAlign(RIGHT, BOTTOM);
        text(scoreLines, width - 10, height - 10);
        
    }
    
    void drawHowTo(){
        fill(255);
        strokeWeight(0);
        textAlign(CENTER, CENTER);
        text("How to Play:\nSurvive the waves of bullets without getting hit.\nYou get hit if your small inner circle hits a bullet."+
            "\n\nHow to Score:\nGraze as many bullets as you can.\nYou graze a bullet when it hits your large outer circle."+
            "\n\nHow to Control:\nArrow keys to move.\nHolding shift makes your small inner circle easier to see,\nbut also makes you move slower."+
            "\n\nHow to Create:\nFind How_to_Program.txt in the data folder.\nFollow the instructions there to make your own custom levels!" +
            "\n\nHow to Win:\nTry to beat your time.\nIf you beat the whole level, then try to beat your score instead!"
            , width/2, height/2);
        textAlign(LEFT, BOTTOM);
        text("Z to play", 10, 590);
    }
    
    void drawMapSelector(){
        
    }
    
    void reset(){
        subMenu = 0;
        position = false;
        rectY = 300;
    }
    
}