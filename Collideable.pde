interface Collideable extends Drawable{
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