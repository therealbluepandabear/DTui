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

            if (textAlignment == TextAlignment.right) {
                position = dimensions.width - text.length + pos;
            } else if (textAlignment == TextAlignment.left) {
                position = pos;
            } else {
            }

            cells ~= Cell(Coordinates(cast(int)position, 0), text[pos], color);

        }

        for (int x = 0; x < dimensions.width; ++x) {
            for (int y = 0; y < dimensions.height; ++y) {
                cells ~= Cell(Coordinates(x, y), '*', color);
            }
        }

        return cells;
    }
}
