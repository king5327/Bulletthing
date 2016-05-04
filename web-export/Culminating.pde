//Player player;
    
int gameState; //MENU, HOW-TO, 

int up_key = false, down_key = false, left_key = false, right_key = false, lshift_key = false, z_key = false, x_key = false;

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
    if(key == CODED){
        switch(keyCode){
            case UP:
                up_key = 1;
                break;
            case DOWN:
                down_key = 1;
                break;
            case LEFT:
                left_key = 1;
                break;
            case RIGHT:
                right_key = 1;
                break;
            case SHIFT:
                shift_key = 1;
                break;
        } 
    }
    else{
        switch(key){
            case "Z":
            case "z":
                z_key = 1;
                break;
            case "X":
            case "x":
                x_key = 1;
                break;
        }
    }
}

keyReleased(){
    if(key == CODED){
        switch(keyCode){
            case UP:
                up_key = 0;
                break;
            case DOWN:
                down_key = 0;
                break;
            case LEFT:
                left_key = 0;
                break;
            case RIGHT:
                right_key = 0;
                break;
            case SHIFT:
                shift_key = 0;
                break;
        } 
    }
    else{
        switch(key){
            case "Z":
            case "z":
                z_key = 0;
                break;
            case "X":
            case "x":
                x_key = 0;
                break;
        }
    }
}

class ObjectsManager{
    Timeline timeline;
    ArrayList bursts = new ArrayList<Burst>;
    ArrayList enemies = new ArrayList<Enemy>;
    ArrayList bullets = new ArrayList<Bullet>;
    
    float startTime, pauseTime, currentTime; //Handles timeline management and smooth pausing.
    boolean paused;
    
    for(Burst burst : bursts.toArray()){
        burst.tick();
    }
    for(Enemy enemy : enemies.toArray()){
        enemy.tick();
    }
    for(Bullet bullet : bullets.toArray()){
        if(bullet.tick())
            bullet.draw();
        else
            bullets.remove(bullet);
    }
    
    
    
}
final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline{
    String sourceFile();
    
    public Timeline(String source){
        sourceFile = source;
        
    }
    
    ArrayList sequence
    
    tick(float m){
        
    }
    
    
}

public class Burst{
    
    
    
    
}

public class Enemy{
    boolean destroyOnEscape = true;
    int health = 1;
    
    
    
}

public class Bullet{
    boolean friendly = false;
    int damage = 0;
    
    
    
}

