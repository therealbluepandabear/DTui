module renderable.chart;

import renderable.renderable;
import color;
import coordinate;
import cell;
import renderable.renderable;
import dimension;
import horizontaltextalignment;
import verticaltextalignment;
import renderable.rect;
import std.algorithm;
import renderable.stacklayout;
import stacklayouttype;
import renderable.cellcachecontainer;
import charttype;

class Chart : Renderable {
    ChartType chartType;
    int[] data;
    int columnWidth;
    int columnSpace;
    Color chartColor;
    Color backgroundColor;

    private CellCacheContainer container;

    this(ChartType chartType, int[] data, int columnWidth, int columnSpace, Color chartColor = Color.White, Color backgroundColor = Color.terminal()) {
        Dimension dimension = Dimension(data.maxElement, cast(int)((data.length * columnSpace) + (data.length * columnWidth) - columnSpace));

        if (chartType == ChartType.bar) {
            this.dimension = dimension;
        } else {
           this.dimension = Dimension(dimension.height, dimension.width);
        }

        this.chartType = chartType;
        this.data = data;
        this.columnWidth = columnWidth;
        this.columnSpace = columnSpace;
        this.chartColor = chartColor;
        this.backgroundColor = backgroundColor;

        container = new CellCacheContainer();
    }

    override Cell[] render() {
        foreach (indx, num; data) {
            Rect rect = Rect.withFill(Dimension(columnWidth, num), chartColor);

            if (chartType == ChartType.bar) {
                rect.dimension = Dimension(rect.dimension.height, rect.dimension.width);
            }

            Coordinate coordinates = Coordinate(0, cast(int)((indx * columnSpace) + (indx * columnWidth)));

            if (chartType == ChartType.bar) {
                container.updateCache(rect, coordinates);
            } else {
                container.updateCache(rect, Coordinate(coordinates.y, this.dimension.height - num));
            }
        }

        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(Dimension(dimension.width, dimension.height), backgroundColor), Coordinate(0, 0));
        }

        return container.cache;
    }
}
