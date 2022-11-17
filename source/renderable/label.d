module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;

class Label : Renderable {
    string text;
    Color color;

    override Dimensions getDimensions() {
        return Dimensions(cast(int)text.length, cast(int)text.length);
    }

    override Cell[] render() {
        Cell[] cells;

        for (int x = 0; x < 0 + text.length; ++x) {
            cells ~= Cell(Coordinates(x, 0), text[x], color);
        }

        return cells;
    }
}
