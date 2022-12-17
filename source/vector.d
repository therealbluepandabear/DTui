module vector;

struct Vector {
    int x;
    int y;

    static Vector block(int x, int y) {
        return Vector(x * 2, y);
    }
}
