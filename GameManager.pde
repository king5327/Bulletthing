class GameManager implements Tickable{
    ArrayList timelines = new ArrayList<Timeline>();
    ArrayList bursts = new ArrayList<Burst>();
    ArrayList enemies = new ArrayList<Enemy>();
    ArrayList bullets = new ArrayList<Bullet>();

    float startTime, pauseTime, currentTime; //Handles timeline management and smooth pausing.
    boolean paused;

    void tick() {
        currentTime = millis();
        player.draw();
        for (Timeline line : (Timeline[]) timelines.toArray()){
            if(! line.tick(currentTime - startTime))
                timelines.remove(line);
        }
        for (Burst burst : (Burst[]) bursts.toArray ()) {
            burst.tick(currentTime - startTime);
        }
        for (Enemy enemy : (Enemy[]) enemies.toArray ()) {
            if(enemy.tick(currentTime - startTime)){
                enemy.draw();
                player.collide(enemy);
            }else
                enemies.remove(enemy);
        }
        for (Bullet bullet : (Bullet[]) bullets.toArray ()) {
            if (bullet.tick(currentTime - startTime)) {
                bullet.draw();
                player.collide(bullet);
            } else {
                bullets.remove(bullet);
            }
        }
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
