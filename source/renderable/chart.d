module renderable.chart;

import renderable.renderable;
import color;
import vector;
import cell;
import renderable.renderable;
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
        Vector dimension = Vector(data.maxElement, cast(int)((data.length * columnSpace) + (data.length * columnWidth) - columnSpace));

        if (chartType == ChartType.bar) {
            this.dimension = dimension;
        } else {
           this.dimension = Vector(dimension. y , dimension. x );
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
            Rect rect = Rect.withFill(Vector(columnWidth, num), chartColor);

            if (chartType == ChartType.bar) {
                rect.dimension = Vector(rect.dimension. y , rect.dimension. x );
            }

            Vector coordinates = Vector(0, cast(int)((indx * columnSpace) + (indx * columnWidth)));

            if (chartType == ChartType.bar) {
                container.updateCache(rect, coordinates);
            } else {
                container.updateCache(rect, Vector(coordinates.y, this.dimension. y  - num));
            }
        }

        if (backgroundColor != Color.terminal()) {
            container.updateCache(Rect.withFill(Vector(dimension. x , dimension. y ), backgroundColor), Vector(0, 0));
        }

        return container.cache;
    }
}
