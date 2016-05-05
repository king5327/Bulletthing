int gameState; //MENU, HOW-TO, 

int up_key = 0, down_key = 0, left_key = 0, right_key = 0, shift_key = 0, z_key = 0, x_key = 0;

void setup() {
    size(500, 600);
    gameState = 0;
}

int phase, stage; 
void draw() {
}

void menu() {
    //Two simple draws and one box to designate selection.
}

void keyPressed() { //Handle keypresses.
    if (key == CODED) {
        switch(keyCode) {
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
    } else {
        switch(key) {
        case 'Z':
        case 'z':
            z_key = 1;
            break;
        case 'X':
        case 'x':
            x_key = 1;
            break;
        }
    }
}

void keyReleased() { //And key releases.
    if (key == CODED) {
        switch(keyCode) {
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
    } else {
        switch(key) {
        case 'Z':
        case 'z':
            z_key = 0;
            break;
        case 'X':
        case 'x':
            x_key = 0;
            break;
        }
    }
}

class ObjectsManager {
    Timeline timeline;
    ArrayList bursts = new ArrayList<Burst>();
    ArrayList enemies = new ArrayList<Enemy>();
    ArrayList bullets = new ArrayList<Bullet>();

    float startTime, pauseTime, currentTime; //Handles timeline management and smooth pausing.
    boolean paused;

    void tick() {
        for (Burst burst : (Burst[]) bursts.toArray ()) {
            burst.tick(currentTime - startTime);
        }
        for (Enemy enemy : (Enemy[]) enemies.toArray ()) {
            if(enemy.tick(currentTime - startTime)){
                enemy.draw();
            }else
                enemies.remove(enemy);
        }
        for (Bullet bullet : (Bullet[]) bullets.toArray ()) {
            if (bullet.tick(currentTime - startTime)) {
                bullet.draw();
            } else {
                bullets.remove(bullet);
            }
        }
    }
}

