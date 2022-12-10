module renderable.rect;

import color;
import coordinate;
import cell;
import renderable.renderable;
import dimension;
import std.stdio;

class Rect : Renderable {
    private enum RectType {
        fill, frame, empty
    }

    RectType rectType;
    Color fillColor;
    Color frameColor;

    static Rect withFill(Dimension dimension, Color fillColor) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.fill;
        rect.fillColor = fillColor;

        return rect;
    }

    static Rect withFrame(Dimension dimension, Color frameColor) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.frame;
        rect.frameColor = frameColor;

        return rect;
    }

    static Rect empty(Dimension dimension) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.empty;
        rect.fillColor = Color.terminal();

        return rect;
    }

    override Cell[] render() {
        Cell[] cells;

        Coordinate from = Coordinate(0, 0);
        Coordinate to = Coordinate(dimension.width - 1, dimension.height - 1);

        if (rectType != RectType.empty && rectType != RectType.fill) {
            for (int x = from.x; x <= to.x; ++x) {
                if (rectType == RectType.frame) {
                    wchar content1;
                    wchar content2;

                    if (x == from.x) {
                        content1 = '└';
                    } else if (x == to.x) {
                        content1 = '┘';
                    } else {
                        content1 = '─';
                    }

                    if (x == from.x) {
                        content2 = '┌';
                    } else if (x == to.x) {
                        content2 = '┐';
                    } else {
                        content2 = '─';
                    }

                    cells ~= Cell(Coordinate(x, to.y), content1, frameColor);
                    cells ~= Cell(Coordinate(x, from.y), content2, frameColor);
                } else {

                }
            }

            for (int y = from.y + 1; y < to.y; ++y) {
                if (rectType == RectType.frame) {
                    wchar content = '│';

                    cells ~= Cell(Coordinate(from.x, y), content, frameColor);
                    cells ~= Cell(Coordinate(to.x, y), content, frameColor);
                } else {

                }
            }
        } else {
            for (int x = 0; x < dimension.width; ++x) {
                for (int y = 0; y < dimension.height; ++y) {
                    cells ~= Cell(Coordinate(x, y), ' ', Color.terminal(), fillColor);
                }
            }
        }

        return cells;
    }
}
