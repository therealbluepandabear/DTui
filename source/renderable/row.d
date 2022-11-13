module renderable.row;

import app;
import renderable.rect;
import renderable.renderable;
import coordinates;
import color;
import cell;

class Row {
	private Canvas canvas = new Canvas();
    private Renderable[] children;

	private Coordinates cursor = Coordinates(0, 0);

	void addChild(Renderable renderable) {
		canvas.dimensions.width += renderable.getDimensions().width + 1;
		canvas.dimensions.height += renderable.getDimensions().height + 1;
		canvas.updateCache(renderable, cursor);

        children ~= renderable;
        updateCursor();
	}

    void updateCursor() {
        cursor = Coordinates(children[$ - 1].getDimensions().width + 1, 0);
    }

	void draw() {
		canvas.drawCache();
	}
}