module dimensions;

struct Dimensions {
    int width;
    int height;

    static Dimensions block(int width, int height) {
        return Dimensions(width * 2, height);
    }
}
