module renderable.cellcachecontainer;

import cell;
import renderable.renderable;
import coordinate;
import std.stdio;
import std.algorithm;

class CellCacheContainer {
    Cell[] cache;

    void updateCache(Renderable renderable, Coordinate position) {
        Cell[] renderedCells = renderable.render().dup;

        foreach (ref cell; renderedCells) {
            cell.coordinates.x += position.x;
            cell.coordinates.y += position.y;
        }

        cache ~= renderedCells;
    }
}
