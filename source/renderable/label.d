module renderable.label;

import color;
import coordinate;
import cell;
import renderable.renderable;
import dimension;
import horizontaltextalignment;
import verticaltextalignment;
import renderable.rect;
import std.stdio;

class Label : Renderable {
    Rect rect;
    string text;
    HorizontalTextAlignment horizontalTextAlignment;
    VerticalTextAlignment verticalTextAlignment;
    Color color;

    this(Rect rect, string text, VerticalTextAlignment verticalTextAlignment, Color color = Color.terminal()) {
        this(rect, text, HorizontalTextAlignment.center, verticalTextAlignment, color);
    }

    this(Rect rect, string text, HorizontalTextAlignment horizontalTextAlignment, Color color = Color.terminal()) {
        this(rect, text, horizontalTextAlignment, VerticalTextAlignment.center, color);
    }

    this(Rect rect, string text, Color color) {
        this(rect, text, HorizontalTextAlignment.center, VerticalTextAlignment.center, color);
    }

    this(Rect rect, string text, HorizontalTextAlignment horizontalTextAlignment = HorizontalTextAlignment.center, VerticalTextAlignment verticalTextAlignment = VerticalTextAlignment.center, Color color = Color.terminal()) {
        this.dimension = rect.dimension;
        this.rect = rect;
        this.text = text;
        this.color = color;
        this.horizontalTextAlignment = horizontalTextAlignment;
        this.verticalTextAlignment = verticalTextAlignment;
    }

    override Cell[] render()  {
        Cell[] cells;

        int pos = 0;

        foreach (dchar character; text) {
            long x;
            long y;

            if (horizontalTextAlignment == HorizontalTextAlignment.center) {
                x = (dimension.width / 2 - (text.length / 2)) + pos;
            } else if (horizontalTextAlignment == HorizontalTextAlignment.left) {
                x = pos;
            } else if (horizontalTextAlignment == HorizontalTextAlignment.right) {
                x = (dimension.width - text.length) + pos;
            }

            if (verticalTextAlignment == VerticalTextAlignment.center) {
                y = dimension.height / 2;
            } else if (verticalTextAlignment == VerticalTextAlignment.top) {
                y = 0;
            } else if (verticalTextAlignment == VerticalTextAlignment.bottom) {
                y = dimension.height - 1;
            }

            cells ~= Cell(Coordinate(cast(int)x, cast(int)y), character, color);

            ++pos;
        }

        cells ~= rect.render();

        return cells;
    }
}
