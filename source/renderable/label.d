module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import textalignment;

class Label : Renderable {
    private const string text;
    private const TextAlignment textAlignment;
    private const Color color;

    this(string text, Color color) {
        this(Dimensions(cast(int)(text.length - 1), 1), text, TextAlignment.left, color);
    }

    this(Dimensions dimensions, string text, TextAlignment textAlignment, Color color) {
        this.dimensions = dimensions;
        this.text = text;
        this.textAlignment = textAlignment;
        this.color = color;
    }

    string getText() const {
        return text;
    }

    TextAlignment getTextAlignment() const {
        return textAlignment;
    }

    Color getColor() const {
        return color;
    }

    override Cell[] render() const {
        Cell[] cells;

        for (int x = 0; x < text.length; ++x) {
            cells ~= Cell(Coordinates(x, 0), text[x], color);
        }

        return cells;
    }
}
