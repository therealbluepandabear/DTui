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
import horizontaltextalignment;
import verticaltextalignment;
import stacklayouttype;
import renderable.cellcachecontainer;
import std.random;
import charttype;
import renderable.table;
import renderable.tree;

class Canvas {
	Dimensions dimensions;
	Color backgroundColor;

	private CellCacheContainer container;

	this(Dimensions dimensions, Color backgroundColor = Color.terminal()) {
		this.dimensions = dimensions;
		this.backgroundColor = backgroundColor;
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
	Canvas canvas = new Canvas(Dimensions(300, 300));

	StackLayout row = new StackLayout(StackLayoutType.row);

	row.add(new Tree(Node("Lmao", Node(), Node(Node(), Node(), Node(Node(Node(Node())))), Node(), Node())));
	row.add(new Tree(Node("Lmao", Node(), Node(Node(), Node(), Node(Node(Node(Node())))), Node(), Node())));

	canvas.updateCache(row, Coordinates(0, 0));

	canvas.drawCache();
}