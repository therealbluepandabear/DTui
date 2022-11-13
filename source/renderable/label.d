module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;

class Label : Renderable {
    string text;
    Coordinates origin;
    Color color;

    override Cell[] render() {
        Cell[] cells;

        int loopCount = 0;

        for (int x = origin.x; x < origin.x + text.length; ++x) {
            cells ~= Cell(Coordinates(x, origin.y), text[loopCount], color);
            ++loopCount;
        }

        return cells;
    }
}
