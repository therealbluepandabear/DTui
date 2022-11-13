import std.stdio;
import std.algorithm;
import std.process;
import core.thread.osthread;
import core.time;
import std.random;
import color;
import coordinates;

struct Cell {
	Coordinates coordinates;
	wchar content;
	Color color;
}

struct Rect {
	Coordinates from;
	Coordinates to;
	Color color;

	Cell[] toCells() {
		Cell[] cells;

		for (int x = from.x; x <= to.x; ++x) {
			wchar content;

			if (x == this.from.x) {
				content = '┌';
			} else if (x == this.to.x) {
				content = '┐';
			} else {
				content = '─';
			}

			cells ~= Cell(Coordinates(x, this.from.y), content, color);
		}

		for (int x = from.x; x <= to.x; ++x) {
			wchar content;

			if (x == this.from.x) {
				content = '└';
			} else if (x == this.to.x) {
				content = '┘';
			} else {
				content = '─';
			}

			cells ~= Cell(Coordinates(x, this.to.y), content, color);
		}

		for (int y = from.y + 1; y < to.y; ++y) {
			cells ~= Cell(Coordinates(this.from.x, y), '│', color);
		}

		for (int y = from.y + 1; y < to.y; ++y) {
			cells ~= Cell(Coordinates(this.to.x, y), '│', color);
		}

		return cells;
	}
}

struct Label {
	string text;
	Coordinates origin;
	Color color;

	Cell[] toCells() {
		Cell[] cells;

		int loopCount = 0;

		for (int x = origin.x; x < origin.x + text.length; ++x) {
			cells ~= Cell(Coordinates(x, origin.y), text[loopCount], color);
			++loopCount;
		}

		return cells;
	}
}

class Column {
	private Canvas canvas = new Canvas();

	private Coordinates cursor = Coordinates(0, 0);

	void addRect(int width, int height) {
		canvas.width += width + 1;
		canvas.height += height + 1;

		Coordinates to = cursor;
		to.x += width;
		to.y += height;

		canvas.cacheCells(Rect(cursor, to, Color.Red).toCells());

		cursor = Coordinates(0, to.y + 1);
	}

	void draw() {
		canvas.drawCache();
	}
}

class Row {
	private Canvas canvas = new Canvas();

	private Coordinates cursor = Coordinates(0, 0);

	void addRect(int width, int height) {
		canvas.width += width + 1;
		canvas.height += height + 1;

		Coordinates to = cursor;
		to.x += width;
		to.y += height;

		canvas.cacheCells(Rect(cursor, to, Color.Red).toCells());

		cursor = Coordinates(to.x + 1, 0);
	}

	void draw() {
		canvas.drawCache();
	}
}

class Canvas {
	private int width;
	private int height;
	private char background = ' ';

	private Cell[] cache;

	void cacheCells(Cell[] cells) {
		cache ~= cells;
	}

	void drawCache() {
		Cell[] cellsDrawn;

		for (int y = 0; y < height; ++y) {
			for (int x = 0; x < width; ++x) {
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
					write(background);
				}
			}

			writeln();
		}
	}
}

void main() {
	Row row = new Row();
	row.addRect(10, 5);
	row.addRect(5, 2);
	row.draw();
}