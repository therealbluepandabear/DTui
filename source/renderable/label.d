module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import horizontaltextalignment;
import verticaltextalignment;
import renderable.rect;

class Label : Renderable {
    Rect rect;
    string text;
    HorizontalTextAlignment horizontalTextAlignment;
    VerticalTextAlignment verticalTextAlignment;
    Color color;

    this(string text, Color color) {
        this(Rect.empty(Dimensions(cast(int)(text.length), 1)), text, color);
    }

    this(Rect rect, string text, Color color) {
        this(rect, text, HorizontalTextAlignment.left, color);
    }

    this(Rect rect, string text, HorizontalTextAlignment horizontalTextAlignment, Color color) {
        this(rect, text, horizontalTextAlignment, VerticalTextAlignment.top, color);
    }

    this(Rect rect, string text, HorizontalTextAlignment horizontalTextAlignment, VerticalTextAlignment verticalTextAlignment, Color color) {
        this.dimensions = rect.dimensions;
        this.rect = rect;
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

        cells ~= rect.render();

        return cells;
    }
}
