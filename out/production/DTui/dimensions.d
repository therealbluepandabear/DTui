module dimensions;

import coordinates;

struct Dimensions {
    int width;
    int height;

    Dimensions fromCoordinates(Coordinates from, Coordinates to) {
        return Dimensions(to.x - from.x, to.y - from.y);
    }
}
