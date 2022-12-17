module renderable.rect;

import color;
import vector;
import cell;
import renderable.renderable;
import std.stdio;

class Rect : Renderable {
    private enum RectType {
        fill, frame, empty
    }

    RectType rectType;
    Color fillColor;
    Color frameColor;

    static Rect withFill(Vector dimension, Color fillColor) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.fill;
        rect.fillColor = fillColor;

        return rect;
    }

    static Rect withFrame(Vector dimension, Color frameColor) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.frame;
        rect.frameColor = frameColor;

        return rect;
    }

    static Rect empty(Vector dimension) {
        Rect rect = new Rect();

        rect.dimension = dimension;
        rect.rectType = RectType.empty;
        rect.fillColor = Color.terminal();

        return rect;
    }

    override Cell[] render() {
        Cell[] cells;

        Vector from = Vector(0, 0);
        Vector to = Vector(dimension.x  - 1, dimension.y  - 1);

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

                    cells ~= Cell(Vector(x, to.y), content1, frameColor);
                    cells ~= Cell(Vector(x, from.y), content2, frameColor);
                }
            }

            for (int y = from.y + 1; y < to.y; ++y) {
                if (rectType == RectType.frame) {
                    wchar content = '│';

                    cells ~= Cell(Vector(from.x, y), content, frameColor);
                    cells ~= Cell(Vector(to.x, y), content, frameColor);
                } else {

                }
            }
        } else {
            for (int x = 0; x < dimension. x ; ++x) {
                for (int y = 0; y < dimension. y ; ++y) {
                    cells ~= Cell(Vector(x, y), ' ', Color.terminal(), fillColor);
                }
            }
        }

        return cells;
    }
}
