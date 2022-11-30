import std.stdio;
import std.algorithm;
import std.process;
import core.thread.osthread;
import core.time;
import std.random;
import color;
import coordinates;
import dimensions;
import cell;
import renderable.renderable;
import renderable.rect;
import renderable.label;
import renderable.chart;
import renderable.stacklayout;
import orientation;
import horizontaltextalignment;
import verticaltextalignment;
import stacklayouttype;
import renderable.cellcachecontainer;
import border;

class Canvas {
	Dimensions dimensions;

	private CellCacheContainer container;

	this(Dimensions dimensions) {
		this.dimensions = dimensions;
		container = new CellCacheContainer();
	}

	void updateCache(Renderable renderable, Coordinates position) {
		container.updateCache(renderable, position);
	}

	void drawCache() {
		Cell[] cellsDrawn;

		for (int y = 0; y < dimensions.height; ++y) {
			for (int x = 0; x < dimensions.width; ++x) {
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
					writef("\x1b[m");
					write(' ');
				}
			}

			writeln();
		}
	}
}

void main() {
	Canvas canvas = new Canvas(Dimensions(60, 60));

	StackLayout column = new StackLayout(StackLayoutType.row);

	column.add(new Label(Rect.withFill(Dimensions(20, 20), Color.Blue), "Test", HorizontalTextAlignment.center, VerticalTextAlignment.center, Color.terminal()));
	column.add(new Label(Rect.withFill(Dimensions(20, 10), Color.Red), "Test", HorizontalTextAlignment.center, VerticalTextAlignment.center, Color.Black));

	canvas.updateCache(column, Coordinates(0, 0));
	canvas.drawCache();
}