interface Collideable extends Drawable{ //A set of methods for ensuring smooth collision handling.
    boolean collide(Collideable other);
    float getX();
    float getY();
    float setX(float newX);
    float setY(float newY);
    float getRadius();
    void collided();
    boolean getGrazed();
    void graze();
    
}