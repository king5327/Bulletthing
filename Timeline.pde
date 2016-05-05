final int SECOND = 1000, MINUTE = 60 * SECOND;

public class Timeline implements Tickable {
    String sourceFile;

    public Timeline(String source) {
        sourceFile = source;
    }

    ArrayList sequence = new ArrayList<Step>();

    boolean tick(float m) {
        return false;
    }

    class Step {
    }
}

