interface Tickable { //Tick tock.
    //Interrupt just generally means that if a thing is not responding to ticks, it should return to regular service. It's not used yet.
    //Why it would be stopped depends on the implementation.
    boolean tick(int interval);
    void interrupt();
}