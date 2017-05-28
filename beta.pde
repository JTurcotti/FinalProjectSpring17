import java.util.*;

Grid g;
Vertex root;

void setup() {
    background(255);
    size(2048, 2048);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
    ellipseMode(RADIUS);
    fill(255, 0, 0);
  }

void draw() {
    growCycle();
    if (mousePressed)
	for (Vertex v: g.vertices)
	    ellipse(v.x(), v.y(), 2, 2);
}

void mouseReleased() {
    background(255);
    g.print();
}

void growCycle() {
    for (Vertex v: g.grow())
	v.print();
    println(g.size());
}
