import std.stdio;
import std.algorithm;

struct Coordinates {
	int x;
	int y;
}

struct Cell {
	Coordinates coordinates;
	char content;
}

class Canvas {
	private int width;
	private int height;
	private char background = ' ';

	void draw(Cell[] cells) {
		Cell[] cellsDrawn;

		for (int y = 0; y < height; ++y) {
			for (int x = 0; x < width; ++x) {
				bool cellFound = false;

				foreach (cell; cells) {
					if (cell.coordinates.x == x && cell.coordinates.y == y && !(cellsDrawn.canFind!(cell => cell.coordinates.x == x && cell.coordinates.y == y))) {
						write("*");
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
	Cell cell = Cell(Coordinates(5, 5), '*');

	Canvas canvas = new Canvas();
	canvas.width = 10;
	canvas.height = 10;

	canvas.draw([cell]);
}