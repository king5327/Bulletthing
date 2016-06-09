class GameManager implements Tickable{
    ArrayList timelines = new ArrayList<Timeline>();
    ArrayList bursts = new ArrayList<Burst>();
    ArrayList enemies = new ArrayList<Enemy>();
    ArrayList bullets = new ArrayList<Bullet>();

    int startTime, pauseTime, currentTime; //Handles timeline management and smooth pausing.
    boolean paused;
    
    boolean start(){
        for(Object obj : timelines.toArray()){
            Timeline line = (Timeline) obj;
            line.start(millis() - startTime);
        }
        return true;
    }

    boolean tick(int time){
        return tick();
    }

    boolean tick() { //Good lord I haven't even gotten to the bullets the player spawns. I cry.
        currentTime = millis();
        player.move();
        for (Object obj : timelines.toArray()){
            Timeline line = (Timeline) obj;
            if(! line.tick(currentTime - startTime))
                timelines.remove(line);
        }
        for (Object obj : bursts.toArray ()) {
            Burst burst = (Burst) obj;
            burst.tick(currentTime - startTime);
        }
        for (Object obj : enemies.toArray ()) {
            Enemy enemy = (Enemy) obj;
            if(enemy.tick(currentTime - startTime)){
                enemy.draw();
                player.collide(enemy);
            }else
                enemies.remove(enemy);
        }
        for (Object obj : bullets.toArray ()) {
            Bullet bullet = (Bullet) obj;
            if (bullet.tick(currentTime - startTime)) {
                bullet.draw();
                player.collide(bullet);
            } else {
                println("bullet deleted");
                bullets.remove(bullet);
            }
        }
        player.draw();
        return true;
    }
    
    void pause(){
        if(!paused){
            pauseTime = millis();
            paused = true;
        }
    }
    
    void resume(){
        if(paused){
            startTime += millis() - pauseTime;
            paused = false;
        }
    }
    
    void interrupt(){
        resume();
    }
    
    void reset(){
        timelines.clear();
        bursts.clear();
        enemies.clear();
        bullets.clear();
    }
}