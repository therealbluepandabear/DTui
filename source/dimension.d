module dimension;

struct Dimension {
    int width;
    int height;

    static Dimension block(int width, int height) {
        return Dimension(width * 2, height);
    }
}
