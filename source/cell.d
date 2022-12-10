module cell;

import coordinate;
import color;

struct Cell {
    Coordinate coordinates;
    dchar content;
    Color contentColor;
    Color backgroundColor = Color.terminal();
}
