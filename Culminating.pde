int gameState = 0; //MENU, PREGAME, GAME, PAUSE, BADEND, GOODEND
GameManager manager = new GameManager();
Menu menu = new Menu();
Player player;
HashMap templates = new HashMap(); //This would normally go inside Timeline, but can't make static fields because of processing.
Window window;
PauseMenu pause;
int tickTime;
EndMenu endMenu = new EndMenu();

int up_key = 0, down_key = 0, left_key = 0, right_key = 0, shift_key = 0, z_key = 0, x_key = 0, esc_key = 0;
int left = 25, right = 375, top = 25, bottom = 575; //If you change these god help anybody who made any levels because they don't conform to the standard.

void setup() {
    size(600, 600); //DO NOT change the screen size. It will do nothing, as there's no scaling.
    gameState = 0;
    window = new Window(left, right, top, bottom);
    frameRate(60);
    player = new Player();
    pause = new PauseMenu();
}

int phase, stage; 
void draw() {
    tickTime = millis();
    //Cleanup, then pick stage, then run as it will.
    switch(gameState){
        case 0: //Menu
            background(0);
            menu.draw();
            break;
        case 1: //Pregame setup, run only once, unless failed for whatever reason.
            window.reset();
            if(manager.start()){
                println("Started");
                gameState = 2;
            }else{
                gameState = 0;
                menu.reset();
                break;
            }
        case 2: //Game
            background(200);
            manager.resume();
            manager.tick();
            window.draw();
            break;
        case 3: //Pause, just for fun.
            background(200);
            manager.pause();
            manager.tick();
            window.draw();
            pause.draw();
            break;
        case 4://Both of these are Ends, but one's bad end and the other's good end.
        case 5:
            background(0);
            endMenu.draw();
            break;
        default:
            break;
    }
}

void keyPressed() { //Handle keypresses. Releases set to zero, but don't update it if it's held and other parts change the variable to something other than 0 or 1.
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
        case 'Z'://Four, because I'm also running on Dvorak and don't want to change layouts to play.
        case 'z':
        case ';':
        case ':':
            z_key = z_key == 0 ? 1 : z_key;
            println("z hit");
            break;
        case 'X':
        case 'x':
        case 'q':
        case 'Q':
            x_key = x_key == 0 ? 1 : x_key;
            println("x hit");
            break;
        case ESC:
            println("esc hit");
            esc_key = esc_key == 0 ? 1 : esc_key;
            key = 0;
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
        case ';':
        case ':':
            z_key = 0;
            break;
        case 'X':
        case 'x':
        case 'q':
        case 'Q':
            x_key = 0;
            break;
        case ESC:
            esc_key = 0;
            key = 0;
            break;
        }
    }
}