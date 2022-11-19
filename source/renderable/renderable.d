module renderable.renderable;

import dimensions;
import cell;

abstract class Renderable {
    protected Dimensions dimensions;

    Dimensions getDimensions() {
        return dimensions;
    }

    abstract  Cell[] render();
}
