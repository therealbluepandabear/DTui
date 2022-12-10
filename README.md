# DTui
🚧 WIP 🚧 Terminal user interface library for D language

# About
DTui is a terminal user interface (TUI) library for D language that I am working on in my free time to help better understand D. 

_Keep in mind:_

1. The library's first version has not been released yet.

2. Note that I am new to D so this is not a professional project.

3. Output images are in the IntelliJ IDEA 'Run' window.

# Controls

### Tree

#### Construction:

```D
void main() {
  Canvas canvas = new Canvas();

  Tree tree = new Tree(Node("A", Node("B1", Node("C1"), Node("C2")), Node("B2", Node("D1"), Node("D2")), Node("B3", Node("E1"), Node("E2"))));

  canvas.updateCache(tree, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output:

![image](https://user-images.githubusercontent.com/50536495/206823364-8bac098d-4cb7-47c1-ae07-abb4f6cd9b17.png)

### Chart

#### Construction:

```D
void main() {
  Canvas canvas = new Canvas();

  Chart chart = new Chart(ChartType.column, [1, 4, 9, 2], 3, 1, Color.Red);

  canvas.updateCache(chart, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output:

![image](https://user-images.githubusercontent.com/50536495/206823537-27aecc3e-4c4e-47bb-8356-b618a3cf97db.png)

### Rect (with fill)

#### Construction

```D
void main() {
  Canvas canvas = new Canvas();

  Rect rect = Rect.withFill(Dimensions(20, 10), Color.Orange);

  canvas.updateCache(rect, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output:

![image](https://user-images.githubusercontent.com/50536495/206823643-c8144414-4400-4f2a-8a07-91c8e2af8eff.png)

### Rect (with frame)

#### Construction

```D
void main() {
  Canvas canvas = new Canvas();

  Rect rect = Rect.withFrame(Dimensions(20, 10), Color.Blue);

  canvas.updateCache(rect, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output

![image](https://user-images.githubusercontent.com/50536495/206823766-0f3b8979-f5ea-4df1-b2dc-ed0bc5cc4714.png)

### Table 

#### Construction

```D
void main() {
  Canvas canvas = new Canvas();

  Table table = new Table(10, 5);

  canvas.updateCache(table, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output

![image](https://user-images.githubusercontent.com/50536495/206823898-2a7a2b32-b8f9-4fa4-8360-e2b119dd7c27.png)

### Label 

#### Construction

```D
void main() {
  Canvas canvas = new Canvas();

  Label label = new Label(Rect.withFill(Dimension.block(30, 11), Color.Black), "Hello World!", Color.Orange);

  canvas.updateCache(label, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output

![image](https://user-images.githubusercontent.com/50536495/206827254-a7ed9876-4bc3-4380-8983-9254f3bdc7f9.png)

### StackLayout 

#### Construction

```D
void main() {
  Canvas canvas = new Canvas();

  Rect rectr = Rect.withFill(Dimension(10, 10), Color.Blue);
  Rect rectb = Rect.withFill(Dimension(10, 10), Color.Red);

  StackLayout row = new StackLayout(StackLayoutType.row);

  row.add(rectr, rectb, rectr, rectb, rectr);

  canvas.updateCache(row, Coordinate(0, 0));
  canvas.drawCache();
}
```

#### Output

![image](https://user-images.githubusercontent.com/50536495/206827160-86bd68b6-6ded-4559-991c-446a4bce8aee.png)





