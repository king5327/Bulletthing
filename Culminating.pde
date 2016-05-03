//Player player;
    
int gameState; //MENU, HOW-TO, 

boolean up = false, down = false, left = false, right = false, shift = false, z_key = false, x_key = false;

void setup(){
    size(600, 800);
    gameState = MENU;
}

int phase, stage; 
void draw(){
    
}

void menu(){
    //Two simple draws and one box to designate selection.
}

keyPressed(){
    switch(keyCode){
        case UP:
        break;
        case DOWN:
        break;
        case LEFT:
        break;
        case RIGHT:
        break;
        case:
        break;        
        case:
        break;        
        case:
        break;        
    }
}

keyReleased(){
    
}

class ObjectsManager{
    Bullet[] bullets;
    Enemy[] enemies;
    Timeline timeline;
    
    float startTime, pauseTime; //Handles timeline management and smooth pausing.
    boolean paused;
    
    
    
    
}
