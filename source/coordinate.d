module coordinate;

struct Coordinate {
    int x;
    int y;

    static Coordinate block(int x, int y) {
        return Coordinate(x * 2, y);
    }
}
