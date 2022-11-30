module renderable.rect;

import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import std.stdio;
import border;

class Rect : Renderable {
    private enum RectType {
        fill, border, frame, empty
    }

    RectType rectType;
    Color fillColor;
    Color frameColor;

    static Rect withFill(Dimensions dimensions, Color fillColor) {
        Rect rect = new Rect();

        rect.dimensions = dimensions;
        rect.rectType = RectType.fill;
        rect.fillColor = fillColor;

        return rect;
    }

    static Rect withFrame(Dimensions dimensions, Color frameColor) {
        Rect rect = new Rect();

        rect.dimensions = dimensions;
        rect.rectType = RectType.frame;
        rect.frameColor = frameColor;

        return rect;
    }

    static Rect empty(Dimensions dimensions) {
        Rect rect = new Rect();

        rect.dimensions = dimensions;
        rect.rectType = RectType.empty;

        return rect;
    }

    override Cell[] render() {
        Cell[] cells;

        Coordinates from = Coordinates(0, 0);
        Coordinates to = Coordinates(dimensions.width - 1, dimensions.height - 1);

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

                    cells ~= Cell(Coordinates(x, to.y), content1, frameColor);
                    cells ~= Cell(Coordinates(x, from.y), content2, frameColor);
                } else {

                }
            }

            for (int y = from.y + 1; y < to.y; ++y) {
                if (rectType == RectType.frame) {
                    wchar content = '│';

                    cells ~= Cell(Coordinates(from.x, y), content, frameColor);
                    cells ~= Cell(Coordinates(to.x, y), content, frameColor);
                } else {

                }
            }
        } else {
            for (int x = 0; x < dimensions.width; ++x) {
                for (int y = 0; y < dimensions.height; ++y) {
                    cells ~= Cell(Coordinates(x, y), ' ', Color.terminal(), fillColor);
                }
            }
        }

        return cells;
    }
}
