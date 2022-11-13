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

class Canvas {
	Dimensions dimensions;

	private Cell[] cache;

	void updateCache(Renderable renderable, Coordinates position) {
		Cell[] renderedCells = renderable.render();

		foreach (ref cell; renderedCells) {
			cell.coordinates.x += position.x;
			cell.coordinates.y += position.y;
		}

		cache ~= renderedCells;
	}

	void drawCache() {
		Cell[] cellsDrawn;

		for (int y = 0; y < dimensions.height; ++y) {
			for (int x = 0; x < dimensions.width; ++x) {
				bool cellFound = false;

				foreach (cell; this.cache) {
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

void canvas() {
	Canvas canvas = new Canvas();
	canvas.dimensions = Dimensions(50, 50);

	Rect rect = new Rect();
	rect.dimensions = Dimensions(10, 10);
	rect.color = Color.Blue;

	Label label = new Label();
	label.text = "Hi";
	label.color = Color.Red;

	canvas.updateCache(rect, Coordinates(5, 5));
	canvas.updateCache(rect, Coordinates(8, 8));

	canvas.updateCache(label, Coordinates(0, 0));
	canvas.updateCache(label, Coordinates(40, 49));

	canvas.drawCache();
}

void main() {
	StackLayout row = new StackLayout();
	row.orientation = Orientation.horizontal;

	Rect rect = new Rect();
	rect.dimensions = Dimensions(10, 10);
	rect.color = Color.Blue;

	Label label = new Label();
	label.text = "Hi";
	label.color = Color.Red;

	row.addChild(rect);
	row.addChild(rect);
	row.addChild(rect);
	row.addChild(label);


	row.draw();
}