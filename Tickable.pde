interface Tickable {
    boolean tick(int time);
    void interrupt();
}