module cell;

import vector;
import color;

struct Cell {
    Vector coordinates;
    dchar content;
    Color contentColor;
    Color backgroundColor = Color.terminal();
}
