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

    private CellCacheContainer container;

    this(int[] data) {
        this.dimensions = Dimensions(cast(int)data.length, data.maxElement);
        this.data = data;
        container = new CellCacheContainer();
    }

    override Cell[] render() {
        foreach (indx, num; data) {
            Rect rect = new Rect(Dimensions(1, num), false, '*', Color.Red);

            container.updateCache(rect, Coordinates(cast(int)indx, dimensions.height - num));
        }

        return container.cache;
    }
}
