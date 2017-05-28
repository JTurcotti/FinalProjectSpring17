import java.util.*;

Grid g;
Vertex root;
int i;
boolean printing = true;

void setup() {
    background(255);
    size(2048, 2048);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
  }

void draw() {
    if (i++%5==0 && printing) growCycle();

}

void mouseReleased() {
    printing = false;

    City c = new City();
    c.streets = g;
    background(255);
    delay(1000);
    g.root.neighbors.get(0).printNet();
    c.genBlocks();
    c.blocks.first().print();
    
}

void growCycle() {
    for (Vertex v: g.grow())
	v.print();
    println(g.size());
}
