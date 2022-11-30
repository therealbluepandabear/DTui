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
    int columnWidth;
    int columnSpace;
    Color color;

    private CellCacheContainer container;

    this(int[] data, int columnWidth, int columnSpace, Color color) {
        this.dimensions = Dimensions(cast(int)((data.length * columnSpace) + (data.length * columnWidth) - columnSpace), data.maxElement);
        this.data = data;
        this.columnWidth = columnWidth;
        this.columnSpace = columnSpace;
        this.color = color;
        container = new CellCacheContainer();
    }

    override Cell[] render() {
        foreach (indx, num; data) {
            Rect rect = Rect.withFill(Dimensions(columnWidth, num), color);

            container.updateCache(rect, Coordinates(cast(int)((indx * columnSpace) + (indx * columnWidth)), dimensions.height - num));
        }

        return container.cache;
    }
}
