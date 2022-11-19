module renderable.label;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import textalignment;

class Label : Renderable {
    private  string text;
    private  TextAlignment textAlignment;
    private  Color color;

    this( string text,  Color color) {
        this(Dimensions(cast(int)(text.length - 1), 1), text, TextAlignment.left, color);
    }

    this( Dimensions dimensions,  string text,  TextAlignment textAlignment,  Color color) {
        this.dimensions = dimensions;
        this.text = text;
        this.textAlignment = textAlignment;
        this.color = color;
    }

    string getText()  {
        return text;
    }

    TextAlignment getTextAlignment()  {
        return textAlignment;
    }

    Color getColor()  {
        return color;
    }

    override Cell[] render()  {
        Cell[] cells;

        for (int x = 0; x < text.length; ++x) {
            cells ~= Cell(Coordinates(x, 0), text[x], color);
        }

        return cells;
    }
}
