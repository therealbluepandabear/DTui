module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import horizontaltextalignment;
import verticaltextalignment;

class Label : Renderable {
    string text;
    HorizontalTextAlignment horizontalTextAlignment;
    VerticalTextAlignment verticalTextAlignment;
    Color color;

    this(string text, Color color) {
        this(Dimensions(cast(int)(text.length), 1), text, Color.Red);
    }

    this(Dimensions dimensions, string text, Color color) {
        this(dimensions, text, HorizontalTextAlignment.left, color);
    }

    this(Dimensions dimensions, string text, HorizontalTextAlignment horizontalTextAlignment, Color color) {
        this(dimensions, text, horizontalTextAlignment, VerticalTextAlignment.center, color);
    }

    this(Dimensions dimensions, string text, HorizontalTextAlignment horizontalTextAlignment, VerticalTextAlignment verticalTextAlignment, Color color) {
        this.dimensions = dimensions;
        this.text = text;
        this.horizontalTextAlignment = horizontalTextAlignment;
        this.verticalTextAlignment = verticalTextAlignment;
        this.color = color;
    }

    override Cell[] render()  {
        Cell[] cells;

        foreach (pos, character; text) {
            long x;
            long y;

            if (horizontalTextAlignment == HorizontalTextAlignment.center) {
                x = (dimensions.width / 2 - (text.length / 2)) + pos;
            } else if (horizontalTextAlignment == HorizontalTextAlignment.left) {
                x = pos;
            } else if (horizontalTextAlignment == HorizontalTextAlignment.right) {
                x = (dimensions.width - text.length) + pos;
            }

            if (verticalTextAlignment == VerticalTextAlignment.center) {
                y = dimensions.height / 2;
            } else if (verticalTextAlignment == VerticalTextAlignment.top) {
                y = 0;
            } else if (verticalTextAlignment == VerticalTextAlignment.bottom) {
                y = dimensions.height - 1;
            }

            cells ~= Cell(Coordinates(cast(int)x, cast(int)y), text[pos], color);

        }

        for (int x = 0; x < dimensions.width; ++x) {
            for (int y = 0; y < dimensions.height; ++y) {
                cells ~= Cell(Coordinates(x, y), '*', color);
            }
        }

        return cells;
    }
}
