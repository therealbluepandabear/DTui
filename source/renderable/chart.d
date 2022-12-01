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
    Color chartColor;
    Color backgroundColor;

    private CellCacheContainer container;

    this(int[] data, int columnWidth, int columnSpace, Color chartColor = Color.White, Color backgroundColor = Color.terminal()) {
        this.dimensions = Dimensions(cast(int)((data.length * columnSpace) + (data.length * columnWidth) - columnSpace), data.maxElement);
        this.data = data;
        this.columnWidth = columnWidth;
        this.columnSpace = columnSpace;
        this.chartColor = chartColor;
        this.backgroundColor = backgroundColor;
        container = new CellCacheContainer();
    }

    override Cell[] render() {
        foreach (indx, num; data) {
            Rect rect = Rect.withFill(Dimensions(columnWidth, num), chartColor);

            container.updateCache(rect, Coordinates(cast(int)((indx * columnSpace) + (indx * columnWidth)), dimensions.height - num));
        }

        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(Dimensions(dimensions.width, dimensions.height), backgroundColor), Coordinates(0, 0));
        }

        return container.cache;
    }
}
