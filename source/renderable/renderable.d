module renderable.renderable;

import dimensions;
import cell;

interface Renderable {
    Dimensions getDimensions();
    Cell[] render();
}
