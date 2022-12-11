import std.stdio;
import std.algorithm;
import std.process;
import core.thread.osthread;
import core.time;
import std.random;
import color;
import coordinate;
import dimension;
import cell;
import renderable.renderable;
import renderable.rect;
import renderable.label;
import renderable.chart;
import renderable.stacklayout;
import horizontaltextalignment;
import verticaltextalignment;
import stacklayouttype;
import renderable.cellcachecontainer;
import std.random;
import charttype;
import renderable.table;
import renderable.tree;

class Canvas {
	Dimension dimension;
	Color backgroundColor;

	private bool wrapContent = false;
	private CellCacheContainer container;

	this(Color backgroundColor = Color.terminal()) {
		this.wrapContent = true;
		this(Dimension(1, 1), backgroundColor);
	}

	this(Dimension dimension, Color backgroundColor = Color.terminal()) {
		this.dimension = dimension;
		this.backgroundColor = backgroundColor;

		container = new CellCacheContainer();
	}

	void updateCache(Renderable renderable, Coordinate position) {
		if (wrapContent) {
			this.dimension.width += renderable.dimension.width;
			this.dimension.height += renderable.dimension.height;
		}

		container.updateCache(renderable, position);
	}

	void drawCache() {
		Cell[] cellsDrawn;

		for (int y = 0; y < dimension.height; ++y) {
			for (int x = 0; x < dimension.width; ++x) {
				bool cellFound = false;

				foreach (cell; container.cache) {
					if (cell.coordinates.x == x && cell.coordinates.y == y && !(cellsDrawn.canFind!(cell => cell.coordinates.x == x && cell.coordinates.y == y))) {
						if (cell.backgroundColor != Color.terminal()) {
							writef("\x1b[48;2;%s;%s;%sm", cell.backgroundColor.r, cell.backgroundColor.g, cell.backgroundColor.b);
						}

						if (cell.contentColor != Color.terminal()) {
							writef("\x1b[38;2;%s;%s;%sm", cell.contentColor.r, cell.contentColor.g, cell.contentColor.b);
						}

						write(cell.content);
						cellsDrawn ~= cell;
						cellFound = true;
					}
				}

				if (!cellFound) {
					if (backgroundColor == Color.terminal()) {
						writef("\x1b[m");
					} else {
						writef("\x1b[48;2;%s;%s;%sm", backgroundColor.r, backgroundColor.g, backgroundColor.b);
					}

					write(' ');
					writef("\x1b[m");
				}
			}

			writeln();
		}
	}
}

void main() {
	Canvas canvas = new Canvas(Dimension(50, 50));

	StackLayout column = new StackLayout(StackLayoutType.column, 1, Color.Blue);
	column.add(Rect.withFill(Dimension(3, 3), Color.Red), 3);

	canvas.updateCache(column, Coordinate(0, 0));
	canvas.drawCache();

	writeln(column.dimension.height);
}