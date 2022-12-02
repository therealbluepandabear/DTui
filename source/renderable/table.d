module renderable.table;

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
import dimensions;

class Table : Renderable {
    int columns;
    int rows;
    int columnWidth;
    int rowHeight;

    this(int columns, int rows, int columnWidth = 7, int rowHeight = 1) {
        this.dimensions = Dimensions((columns * columnWidth) + 1, (rows * rowHeight) + 1);
        this.columns = columns;
        this.rows = rows;
        this.columnWidth = columnWidth;
        this.rowHeight = rowHeight;
    }

    override Cell[] render() {
        Cell[] cells;

        for (int y = 0; y < this.dimensions.height; ++y) {
            for (int x = 0; x < this.dimensions.width; ++x) {
                if ((x % this.columnWidth == 0) && (y % this.rowHeight != 0)) {
                    cells ~= Cell(Coordinates(x, y), '│', Color.White);
                }

                if (y % rowHeight == 0) {
                    wchar content;

                    if ((x == 0) && (y == 0)) {
                        content = '┌';
                    } else if ((x == this.dimensions.width - 1) && (y == 0)) {
                        content =  '┐';
                    } else if ((x == 0) && (y == this.dimensions.height - 1)) {
                        content = '└';
                    } else if ((x == this.dimensions.width - 1) && (y == this.dimensions.height - 1)) {
                        content = '┘';
                    } else if ((x == 0) && (y != 0)) {
                        content = '├';
                    } else if ((x == this.dimensions.width - 1) && (y != 0)) {
                        content = '┤';
                    } else if ((x > 0) && (x < this.dimensions.width) && (x % this.columnWidth == 0) && (y != 0) && (y < this.dimensions.height - 1)) {
                        content ='┼';
                    } else if ((x > 0) && (x < this.dimensions.width) && (x % this.columnWidth == 0) && (y == 0)) {
                        content = '┬';
                    } else if ((x > 0) && (x < this.dimensions.width) && (x % this.columnWidth == 0))  {
                        content = '┴';
                    } else {
                        content = '─';
                    }

                    cells ~= Cell(Coordinates(x, y), content, Color.White);
                }
            }
        }

        return cells;
    }
}
