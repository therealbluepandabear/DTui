module renderable.rect;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import std.stdio;

class Rect : Renderable {
    bool hasBorder;
    char background;
    Color color;

    this(Dimensions dimensions, bool hasBorder, char background, Color color) {
        this.dimensions = dimensions;
        this.hasBorder = hasBorder;
        this.background = background;
        this.color = color;
    }

    override Cell[] render() {
        Cell[] cells;

        Coordinates from = Coordinates(0, 0);
        Coordinates to = Coordinates(dimensions.width - 1, dimensions.height - 1);

        for (int x = from.x; x <= to.x; ++x) {
            wchar content = background;

            if (hasBorder) {
                if (x == from.x) {
                    content = '┌';
                } else if (x == to.x) {
                    content = '┐';
                } else {
                    content = '─';
                }
            }

            cells ~= Cell(Coordinates(x, from.y), content, color);
        }

        for (int x = from.x; x <= to.x; ++x) {
            wchar content = background;

            if (hasBorder) {
                if (x == from.x) {
                    content = '└';
                } else if (x == to.x) {
                    content = '┘';
                } else {
                    content = '─';
                }
            }

            cells ~= Cell(Coordinates(x, to.y), content, color);
        }

        for (int y = from.y + 1; y < to.y; ++y) {
            wchar defaultEdge = background;

            if (hasBorder) {
                defaultEdge = '│';
            }

            cells ~= Cell(Coordinates(from.x, y), defaultEdge, color);
            cells ~= Cell(Coordinates(to.x, y), defaultEdge, color);
        }

        for (int x = 0; x < dimensions.width; ++x) {
            for (int y = 0; y < dimensions.height; ++y) {
                cells ~= Cell(Coordinates(x, y), background, color);
            }
        }

        return cells;
    }
}
