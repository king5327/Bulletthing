class GameManager implements Tickable{
    ArrayList timelines = new ArrayList<Timeline>();
    ArrayList bursts = new ArrayList<Burst>();
    ArrayList enemies = new ArrayList<Enemy>();
    ArrayList bullets = new ArrayList<Bullet>();

    float startTime, pauseTime, currentTime; //Handles timeline management and smooth pausing.
    boolean paused;
    
    boolean start(){
        return true;
    }

    boolean tick(float time){
        return tick();
    }

    boolean tick() {
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
    
    void reset(){
        timelines.clear();
        bursts.clear();
        enemies.clear();
        bullets.clear();
    }
}