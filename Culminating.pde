int gameState = 0; //MENU, GAME, PAUSE
ObjectsManager manager;
Menu menu = new Menu();
Player player = new Player();

int up_key = 0, down_key = 0, left_key = 0, right_key = 0, shift_key = 0, z_key = 0, x_key = 0;

void setup() {
    size(500, 600);
    gameState = 0;
}

int phase, stage; 
void draw() {
    //Cleanup, then pick stage, then run as it will.
    background(0);
    switch(gameState){
        case 0:
            menu.draw();
            break;
        default:
            break;
    }
}

void keyPressed() { //Handle keypresses.
    if (key == CODED) {
        switch(keyCode) {
        case UP:
            up_key = up_key == 0 ? 1 : up_key;
            break;
        case DOWN:
            down_key = down_key == 0 ? 1 : down_key;
            break;
        case LEFT:
            left_key = left_key == 0 ? 1 : left_key;
            break;
        case RIGHT:
            right_key = right_key == 0 ? 1 : right_key;
            break;
        case SHIFT:
            shift_key = shift_key == 0 ? 1 : shift_key;
            break;
        }
    } else {
        switch(key) {
        case 'Z':
        case 'z':
            z_key = z_key == 0 ? 1 : z_key;
            break;
        case 'X':
        case 'x':
            x_key = x_key == 0 ? 1 : x_key;
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

