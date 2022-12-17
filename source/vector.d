module vector;

import std.format;
import std.exception;

struct Vector {
    int x;
    int y;

    this(int x, int y) {
        enforce(x >= 0, format("X value %s must not be negative", x));
        enforce(y >= 0, format("Y value %s must not be negative", y));

        this.x = x;
        this.y = y;
    }

    this(int size) {
        enforce(size >= 0, format("Size value %s must not be negative", size));

        this.x = size;
        this.y = size;
    }

    string toString() const {
        return format("(%s, %s)", x, y);
    }

    static Vector block(int x, int y) {
        return Vector(x * 2, y);
    }

    void scale(int scalar) {
        enforce(scalar >= 0, format("Scalar value %s must not be negative", scalar));

        this.x *= scalar;
        this.y *= scalar;
    }
}
