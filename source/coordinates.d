module coordinates;

struct Coordinates {
    int x;
    int y;

    static Coordinates block(int x, int y) {
        return Coordinates(x * 2, y);
    }
}
