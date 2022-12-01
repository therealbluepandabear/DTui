module cell;

import coordinates;
import color;

struct Cell {
    Coordinates coordinates;
    wchar content;
    Color contentColor;
    Color backgroundColor = Color.terminal();
}
