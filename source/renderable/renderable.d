module renderable.renderable;

import dimensions;
import cell;

abstract class Renderable {
    protected Dimensions dimensions;

    Dimensions getDimensions() const {
        return dimensions;
    }

    abstract const Cell[] render();
}
