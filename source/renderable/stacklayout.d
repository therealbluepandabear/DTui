module renderable.stacklayout;

import app;
import renderable.rect;
import renderable.renderable;
import coordinates;
import color;
import cell;
import std.stdio;
import std.algorithm;
import orientation;

class StackLayout {
    Orientation orientation = Orientation.horizontal;

    private Canvas canvas = new Canvas();
    private Renderable[] children;

    private Coordinates cursor = Coordinates(0, 0);

    void addChild(Renderable renderable) {
        canvas.dimensions.width += renderable.getDimensions().width + 1;
        canvas.dimensions.height += renderable.getDimensions().height + 1;
        canvas.updateCache(renderable, cursor);

        children ~= renderable;
        updateCursor();
    }

    void updateCursor() {
        if (orientation == Orientation.horizontal) {
            int totalWidth = (children.map!(child => child.getDimensions().width).fold!((a, b) => (a + b))) + cast(int)children.length;

            cursor = Coordinates(totalWidth, 0);
        } else {
            int totalHeight = (children.map!(child => child.getDimensions().height).fold!((a, b) => (a + b))) + cast(int)children.length;

            cursor = Coordinates(0, totalHeight);
        }
    }

    void draw() {
        canvas.drawCache();
    }
}