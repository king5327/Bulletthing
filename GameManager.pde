class GameManager implements Tickable{
    ArrayList timelines = new ArrayList<Timeline>();
    ArrayList bursts = new ArrayList<Burst>();
    ArrayList enemies = new ArrayList<Enemy>();
    ArrayList bullets = new ArrayList<Bullet>();

    int startTime, pauseTime, currentTime, lastTime; //Handles timeline management and smooth pausing.
    public int score;
    boolean paused;
    
    boolean start(){
        reset();
        startTime = tickTime;
        currentTime = tickTime;
        paused = false;
        player.reset();
        //placeholder since I'm not going to bother with more than one line for now.
        this.timelines.add(new Timeline("core-main"));
        startTime = tickTime;
        for(Object obj : timelines.toArray()){
            Timeline line = (Timeline) obj;
            line.start(tickTime - startTime);
        }
        //println(timelines.size());
        return true;
    }

    boolean tick(int time){
        return tick();
    }

    boolean tick() { //Good lord I haven't even gotten to the bullets the player spawns. I cry.
        if(esc_key == 1 && gameState == 2){
            esc_key++;
            gameState = 3;
        }
        lastTime = currentTime;
        if(!paused){
            currentTime = tickTime;
        }
        //println(currentTime - lastTime);
        
        player.move();
        player.drawUnder();
        for (Object obj : timelines.toArray()){ //Tick each of the four types of line (enemies not implemented yet). Remove them if their tick doesn't succeed (false result).
            Timeline line = (Timeline) obj;
            if(! line.tick(currentTime - lastTime)){
                println("removed a timeline?!");
                timelines.remove(line);
            }
        }
        for (Object obj : bursts.toArray ()) {
            Burst burst = (Burst) obj;
            if(!burst.tick(currentTime - lastTime))
                bursts.remove(burst);
        }
        for (Object obj : enemies.toArray ()) {
            Enemy enemy = (Enemy) obj;
            if(enemy.tick(currentTime - lastTime)){
                enemy.draw();
                player.collide(enemy);
            }else{
                //println("enemy deleted");
                enemies.remove(enemy);
            }
        }
        for (Object obj : bullets.toArray ()) {
            Bullet bullet = (Bullet) obj;
            if (bullet.tick(currentTime - lastTime)) {
                bullet.draw();
                player.collide(bullet);
            } else {
                //println("bullet deleted");
                bullets.remove(bullet);
            }
        }
        player.draw();
        
        //println(timelines.size());
        if(timelines.size() == 0 && bursts.size() == 0 && enemies.size() == 0 && bullets.size() == 0){
            gameState = 5;
        }
        
        return true;
    }
    
    void pause(){
        if(!paused){
            pauseTime = tickTime;
            paused = true;
        }
    }
    
    void resume(){
        if(paused){
            startTime += tickTime - pauseTime;
            currentTime += tickTime - pauseTime;
            paused = false;
        }
    }
    
    void interrupt(){
        resume();
    }
    
    void notifyDead(){
        gameState = 4;
    }
    
    void reset(){
        timelines.clear();
        bursts.clear();
        enemies.clear();
        bullets.clear();
        paused = false;
    }
}