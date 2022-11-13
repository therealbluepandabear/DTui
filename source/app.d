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

//class Column {
//	private Canvas canvas = new Canvas();
//
//	private Coordinates cursor = Coordinates(0, 0);
//
//	void addRect(int width, int height) {
//		canvas.width += width + 1;
//		canvas.height += height + 1;
//
//		Coordinates to = cursor;
//		to.x += width;
//		to.y += height;
//
//		canvas.cacheCells(Rect(cursor, to, Color.Red).toCells());
//
//		cursor = Coordinates(0, to.y + 1);
//	}
//
//	void draw() {
//		canvas.drawCache();
//	}
//}
//
//class Row {
//	private Canvas canvas = new Canvas();
//
//	private Coordinates cursor = Coordinates(0, 0);
//
//	void addRect(int width, int height) {
//		canvas.width += width + 1;
//		canvas.height += height + 1;
//
//		Coordinates to = cursor;
//		to.x += width;
//		to.y += height;
//
//		canvas.cacheCells(Rect(cursor, to, Color.Red).toCells());
//
//		cursor = Coordinates(to.x + 1, 0);
//	}
//
//	void draw() {
//		canvas.drawCache();
//	}
//}

class Canvas {
	Dimensions dimensions;

	private Cell[] cache;

	void updateCache(Renderable renderable, Coordinates position) {
		cache ~= renderable.render();
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

void main() {

}