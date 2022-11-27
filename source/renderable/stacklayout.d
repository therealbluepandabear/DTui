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
import renderable.cellcachecontainer;
import stacklayouttype;

class StackLayout : Renderable {
    StackLayoutType stackLayoutType;

    private CellCacheContainer container;
    private Renderable[] children;

    private Coordinates cursor = Coordinates(0, 0);

    this(StackLayoutType stackLayoutType) {
        this.stackLayoutType = stackLayoutType;
        container = new CellCacheContainer();
    }

    void add(Renderable renderable) {
        container.updateCache(renderable, cursor);

        children ~= renderable;

        if (stackLayoutType == stackLayoutType.row) {
            this.dimensions.width += renderable.dimensions.width;
            this.dimensions.height = children.maxElement!(child => child.dimensions.height).dimensions.height;
        } else {
            this.dimensions.width = children.maxElement!(child => child.dimensions.width).dimensions.width;
            this.dimensions.height += renderable.dimensions.height;
        }

        updateCursor();
    }

    void updateCursor() {
        if (stackLayoutType == stackLayoutType.row) {
            cursor = Coordinates(this.dimensions.width, 0);
        } else {
            cursor = Coordinates(0, this.dimensions.height);
        }
    }

    override Cell[] render() {
        return container.cache;
    }
}