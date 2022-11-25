module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import textalignment;

class Label : Renderable {
    string text;
    TextAlignment textAlignment;
    Color color;

    this(Dimensions dimensions, string text, TextAlignment textAlignment, Color color) {
        this.dimensions = dimensions;
        this.text = text;
        this.textAlignment = textAlignment;
        this.color = color;
    }

    override Cell[] render()  {
        Cell[] cells;

        foreach (pos, character; text) {
            long position;
            long index;

            if (textAlignment == TextAlignment.right) {
                position = dimensions.width - pos - 1;
                index = text.length - pos - 1;
            } else {
                position = pos;
                index = pos;
            }

            cells ~= Cell(Coordinates(cast(int)position, 0), text[index], color);

        }

        for (int x = 0; x < dimensions.width; ++x) {
            for (int y = 0; y < dimensions.height; ++y) {
                cells ~= Cell(Coordinates(x, y), ' ', color);
            }
        }

        return cells;
    }
}
