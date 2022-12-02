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
        Dimensions dimensions = Dimensions(data.maxElement, cast(int)((data.length * columnSpace) + (data.length * columnWidth) - columnSpace));

        if (chartType == ChartType.bar) {
            this.dimensions = dimensions;
        } else {
           this.dimensions = Dimensions(dimensions.height, dimensions.width);
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
            Dimensions dimensions = Dimensions(columnWidth, num);

            if (chartType == ChartType.bar) {
                dimensions = Dimensions(dimensions.height, dimensions.width);
            }

            Rect rect = Rect.withFill(dimensions, chartColor);

            Coordinates coordinates = Coordinates(0, cast(int)((indx * columnSpace) + (indx * columnWidth)));

            if (chartType == ChartType.bar) {
                container.updateCache(rect, coordinates);
            } else {
                container.updateCache(rect, Coordinates(coordinates.y, this.dimensions.height - num));
            }
        }

        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(Dimensions(dimensions.width, dimensions.height), backgroundColor), Coordinates(0, 0));
        }

        return container.cache;
    }
}
