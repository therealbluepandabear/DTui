module cell;

import coordinates;
import color;

struct Cell {
    Coordinates coordinates;
    dchar content;
    Color contentColor;
    Color backgroundColor = Color.terminal();
}
