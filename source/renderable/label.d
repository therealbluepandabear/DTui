module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;

class Label : Renderable {
    Dimensions dimensions;
    string text;
    Color color;

    override Dimensions getDimensions() {
        return dimensions;
    }

    override Cell[] render() {
        Cell[] cells;

        for (int x = 0; x < 0 + text.length; ++x) {
            cells ~= Cell(Coordinates(x, 0), text[x], color);
        }

        return cells;
    }
}
