module renderable.renderable;

import cell;
import vector;

abstract class Renderable {
    Vector dimension;

    Cell[] render();
}
