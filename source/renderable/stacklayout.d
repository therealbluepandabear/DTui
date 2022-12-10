module renderable.stacklayout;

import app;
import renderable.rect;
import renderable.renderable;
import coordinate;
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

    Renderable[] children;

    private CellCacheContainer container;

    private Coordinate cursor = Coordinate(0, 0);

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

        updateCursor();

        if (stackLayoutType == StackLayoutType.row) {
            this.dimension.width = cursor.x - spacing;
            this.dimension.height = children.maxElement!(child => child.dimension.height).dimension.height;
        } else {
            this.dimension.width = children.maxElement!(child => child.dimension.width).dimension.width;
            this.dimension.height = cursor.y - spacing;
        }
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
        if (stackLayoutType == StackLayoutType.row) {
            this.cursor = Coordinate(children.map!(child => child.dimension.width).sum() + (cast(int)(children.length) * spacing), 0);
        } else {
            this.cursor = Coordinate(0, children.map!(child => child.dimension.height).sum() + (cast(int)(children.length) * spacing));
        }
    }

    override Cell[] render() {
        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(dimension, backgroundColor), Coordinate(0, 0));
        }

        return container.cache;
    }
}