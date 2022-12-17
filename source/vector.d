module vector;

import std.format;

struct Vector {
    int x;
    int y;

    this(int size) {
        this.x = size;
        this.y = size;
    }

    string toString() const {
        return format("(%s, %s)", x, y);
    }

    static Vector block(int x, int y) {
        return Vector(x * 2, y);
    }
}
