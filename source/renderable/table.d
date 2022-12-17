module renderable.table;

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

class Table : Renderable {
    int columns;
    int rows;
    int columnWidth;
    int rowHeight;
    Color tableColor;

    this(int columns, int rows, Color tableColor) {
        this(columns, rows, 7, 1, tableColor);
    }

    this(int columns, int rows, int columnWidth = 7, int rowHeight = 1, Color tableColor = Color.terminal()) {
        this.dimension = Vector((columns * columnWidth) + 1, (rows * rowHeight) + 1);
        this.columns = columns;
        this.rows = rows;
        this.columnWidth = columnWidth;
        this.rowHeight = rowHeight;
        this.tableColor = tableColor;
    }

    override Cell[] render() {
        Cell[] cells;

        for (int y = 0; y < this.dimension.y; ++y) {
            for (int x = 0; x < this.dimension. x ; ++x) {
                if ((x % this.columnWidth == 0) && (y % this.rowHeight != 0)) {
                    cells ~= Cell(Vector(x, y), '│', this.tableColor);
                }

                if (y % rowHeight == 0) {
                    wchar content;

                    if ((x == 0) && (y == 0)) {
                        content = '┌';
                    } else if ((x == this.dimension. x  - 1) && (y == 0)) {
                        content =  '┐';
                    } else if ((x == 0) && (y == this.dimension. y  - 1)) {
                        content = '└';
                    } else if ((x == this.dimension. x  - 1) && (y == this.dimension. y  - 1)) {
                        content = '┘';
                    } else if ((x == 0) && (y != 0)) {
                        content = '├';
                    } else if ((x == this.dimension. x  - 1) && (y != 0)) {
                        content = '┤';
                    } else if ((x > 0) && (x < this.dimension. x ) && (x % this.columnWidth == 0) && (y != 0) && (y < this.dimension. y  - 1)) {
                        content ='┼';
                    } else if ((x > 0) && (x < this.dimension. x ) && (x % this.columnWidth == 0) && (y == 0)) {
                        content = '┬';
                    } else if ((x > 0) && (x < this.dimension. x ) && (x % this.columnWidth == 0))  {
                        content = '┴';
                    } else {
                        content = '─';
                    }

                    cells ~= Cell(Vector(x, y), content, this.tableColor);
                }
            }
        }

        return cells;
    }
}
