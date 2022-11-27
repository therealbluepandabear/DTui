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
import renderable.stacklayout;
import orientation;
import horizontaltextalignment;
import verticaltextalignment;
import stacklayouttype;
import renderable.cellcachecontainer;

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
						writef("\x1b[38;2;%s;%s;%sm", cell.color.r, cell.color.g, cell.color.b);

						write(cell.content);
						cellsDrawn ~= cell;
						cellFound = true;
					}
				}

				if (!cellFound) {
					write(' ');
				}
			}

			writeln();
		}
	}
}

void main() {
	Canvas canvas = new Canvas(Dimensions(900, 100));

	Rect rect = new Rect(Dimensions(5, 5), Color.Red);
	Rect rect2 = new Rect(Dimensions(5, 5), Color.White);

	StackLayout row = new StackLayout(StackLayoutType.row);

	//row2.addChild(row);





	canvas.updateCache(row, Coordinates(0, 0));
	canvas.drawCache();
}