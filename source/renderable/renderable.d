module renderable.renderable;

import dimensions;
import cell;

abstract class Renderable {
    Dimensions dimensions;

    abstract Cell[] render();
}
