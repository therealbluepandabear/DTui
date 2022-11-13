module renderable.rect;

import color;
import coordinates;
import cell;
import renderable.renderable;

class Rect : Renderable {
    Coordinates from;
    Coordinates to;
    Color color;

    override Cell[] render() {
        Cell[] cells;

        for (int x = from.x; x <= to.x; ++x) {
            wchar content;

            if (x == this.from.x) {
                content = '┌';
            } else if (x == this.to.x) {
                content = '┐';
            } else {
                content = '─';
            }

            cells ~= Cell(Coordinates(x, this.from.y), content, color);
        }

        for (int x = from.x; x <= to.x; ++x) {
            wchar content;

            if (x == this.from.x) {
                content = '└';
            } else if (x == this.to.x) {
                content = '┘';
            } else {
                content = '─';
            }

            cells ~= Cell(Coordinates(x, this.to.y), content, color);
        }

        for (int y = from.y + 1; y < to.y; ++y) {
            cells ~= Cell(Coordinates(this.from.x, y), '│', color);
        }

        for (int y = from.y + 1; y < to.y; ++y) {
            cells ~= Cell(Coordinates(this.to.x, y), '│', color);
        }

        return cells;
    }
}
