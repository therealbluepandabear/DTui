module renderable.rect;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;

class Rect : Renderable {
    private const Color color;

    this(const Dimensions dimensions, const Color color) {
        this.dimensions = dimensions;
        this.color = color;
    }

    Color getColor() const {
        return color;
    }

    override Cell[] render() const {
        Cell[] cells;

        const Coordinates from = Coordinates(0, 0);
        const Coordinates to = Coordinates(dimensions.width, dimensions.height);

        for (int x = from.x; x <= to.x; ++x) {
            wchar content;

            if (x == from.x) {
                content = '┌';
            } else if (x == to.x) {
                content = '┐';
            } else {
                content = '─';
            }

            cells ~= Cell(Coordinates(x, from.y), content, color);
        }

        for (int x = from.x; x <= to.x; ++x) {
            wchar content;

            if (x == from.x) {
                content = '└';
            } else if (x == to.x) {
                content = '┘';
            } else {
                content = '─';
            }

            cells ~= Cell(Coordinates(x, to.y), content, color);
        }

        for (int y = from.y + 1; y < to.y; ++y) {
            cells ~= Cell(Coordinates(from.x, y), '│', color);
        }

        for (int y = from.y + 1; y < to.y; ++y) {
            cells ~= Cell(Coordinates(to.x, y), '│', color);
        }

        return cells;
    }
}
