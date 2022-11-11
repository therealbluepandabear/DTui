import std.stdio;
import std.algorithm;

class Cell {
	int x;
	int y;
	char content;
}

class Canvas {
	private int width;
	private int height;

	void draw(Cell[] cells) {
		Cell[] cellsDrawn;

		for (int y = 0; y < height; ++y) {
			for (int x = 0; x < width; ++x) {
				bool cellFound = false;

				foreach (cell; cells) {
					if (cell.x == x && cell.y == y && !(cellsDrawn.canFind!(cell => cell.x == x && cell.y == y))) {
						write("*");
						cellsDrawn ~= cell;
						cellFound = true;
					}
				}

				if (!cellFound) {
					write(" ");
				}
			}

			writeln();
		}
	}
}

void main() {
}