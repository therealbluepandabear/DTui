module renderable.renderable;

import dimension;
import cell;

abstract class Renderable {
    Dimension dimension;

    Cell[] render();
}
