module renderable.stacklayout;

import app;
import renderable.rect;
import renderable.renderable;
import coordinates;
import color;
import cell;
import std.stdio;
import std.algorithm;
import renderable.cellcachecontainer;
import stacklayouttype;

class StackLayout : Renderable {
    StackLayoutType stackLayoutType;
    int spacing;
    Color backgroundColor;

    private CellCacheContainer container;
    private Renderable[] children;

    private Coordinates cursor = Coordinates(0, 0);

    this(StackLayoutType stackLayoutType, Color backgroundColor) {
        this(stackLayoutType, 0, backgroundColor);
    }

    this(StackLayoutType stackLayoutType, int spacing = 0, Color backgroundColor = Color.terminal()) {
        this.stackLayoutType = stackLayoutType;
        this.spacing = spacing;
        this.backgroundColor = backgroundColor;

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

    void add(Renderable[] renderableArr...) {
        foreach (renderable; renderableArr) {
            add(renderable);
        }
    }

    void add(Renderable renderable, int dup) {
        for (int i = 0; i < dup; ++i) {
            add(renderable);
        }
    }

    void updateCursor() {
        if (stackLayoutType == stackLayoutType.row) {
            cursor = Coordinates(this.dimensions.width + (cast(int)(children.length) * spacing), 0);
        } else {
            cursor = Coordinates(0, this.dimensions.height + (cast(int)(children.length) * spacing));
        }
    }

    override Cell[] render() {
        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(this.dimensions, this.backgroundColor), Coordinates(0, 0));
        }

        return container.cache;
    }
}