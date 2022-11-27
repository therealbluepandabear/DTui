module renderable.chart;

import renderable.renderable;
import color;
import coordinates;
import cell;
import renderable.renderable;
import dimensions;
import horizontaltextalignment;
import verticaltextalignment;
import renderable.rect;
import std.algorithm;
import renderable.stacklayout;
import stacklayouttype;
import renderable.cellcachecontainer;

class Chart : Renderable {
    int[] data;
    int columnSpace;
    Color color;

    private CellCacheContainer container;

    this(int[] data, int columnSpace, Color color) {
        this.dimensions = Dimensions(cast(int)(data.length + (data.length * columnSpace) - columnSpace), data.maxElement);
        this.data = data;
        this.columnSpace = columnSpace;
        this.color = color;
        container = new CellCacheContainer();
    }

    override Cell[] render() {
        foreach (indx, num; data) {
            Rect rect = new Rect(Dimensions(1, num), false, '*', color);

            container.updateCache(rect, Coordinates(cast(int)(indx * (columnSpace + 1)), dimensions.height - num));
        }

        return container.cache;
    }
}
