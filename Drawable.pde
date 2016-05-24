interface Drawable {
    void draw();
    boolean collide(Drawable other);
    float getX();
    float getY();
    float getRadius();
}