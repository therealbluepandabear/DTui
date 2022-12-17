module renderable.stacklayout;

import app;
import renderable.rect;
import renderable.renderable;
import vector;
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
    private Vector cursor = Vector(0, 0);

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
            this.dimension. x  = cursor.x - spacing;
            this.dimension. y  = children.maxElement!(child => child.dimension. y ).dimension. y ;
        } else {
            this.dimension. x  = children.maxElement!(child => child.dimension. x ).dimension. x ;
            this.dimension. y  = cursor.y - spacing;
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
            this.cursor = Vector(children.map!(child => child.dimension. x ).sum() + (cast(int)(children.length) * spacing), 0);
        } else {
            this.cursor = Vector(0, children.map!(child => child.dimension. y ).sum() + (cast(int)(children.length) * spacing));
        }
    }

    override Cell[] render() {
        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(dimension, backgroundColor), Vector(0, 0));
        }

        return container.cache;
    }
}