module renderable.tree;

import app;
import renderable.rect;
import renderable.renderable;
import coordinates;
import color;
import cell;
import std.stdio;
import std.algorithm;
import renderable.cellcachecontainer;
import stacklayouttype;
import std.format;
import dimensions;
import renderable.label;
import renderable.rect;
import stacklayouttype;
import renderable.stacklayout;
import horizontaltextalignment;
import verticaltextalignment;
import std.conv;

struct Node {
    string label = "Node";
    Node[] children;

    protected int level = 0;

    this(string label, Node[] children...) {
        this(children);
        this.label = label;
    }

    this(Node[] children...) {
        this.children = children;
    }
}

private static class NodeLevelAssigner {
    static void assignLevel(Node node) {
        foreach (ref child; node.children) {
            child.level = node.level + 1;
            assignLevel(child);
        }
    }
}

class Tree : Renderable {
    Node rootNode;

    this(Node rootNode) {
        this.dimensions = Dimensions();
        this.rootNode = rootNode;

        NodeLevelAssigner.assignLevel(this.rootNode);
    }

    private void printTree(Node root, StackLayout column) {
        foreach (indx, child; root.children) {
            string labelText;

            for (int i = 0; i < child.level; ++i) {
                labelText ~= "  ";

                if (i == (child.level - 1)) {
                    if (indx == (root.children.length - 1)) {
                        labelText ~= "└";
                    } else {
                        labelText ~= "├";
                    }

                    labelText ~= (" " ~ child.label);
                }
            }

            int len = cast(int)(labelText.length) - 4;

            ++this.dimensions.height;

            if (len > this.dimensions.width) {
                this.dimensions.width = len;
            }

            column.add(new Label(Rect.empty(Dimensions(len, 1)), labelText.idup));

            printTree(child, column);
        }
    }

    override Cell[] render() {
        StackLayout column = new StackLayout(StackLayoutType.column);

        column.add(new Label(Rect.empty(Dimensions(cast(int)(rootNode.label.length), 1)), rootNode.label));
        printTree(rootNode, column);

        return column.render();
    }
}
