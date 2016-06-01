interface Collideable extends Drawable{
    boolean Collide(Collideable other);
    float getX();
    float getY();
    float setX();
    float setY();
    float destroy();
    
}