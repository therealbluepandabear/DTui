module renderable.renderable;

import dimensions;
import cell;

abstract class Renderable {
    Dimensions dimensions;

    Cell[] render();
}
