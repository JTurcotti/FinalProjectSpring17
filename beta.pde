import java.util.*;

Grid g;
Vertex root;

void setup() {
    size(1536, 1536);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
  }

void draw() {
    keyReleased();
}

void keyReleased() {
    for (Vertex v: g.grow())
	v.print();
    println(g.size());
}
// =========TESTING METHODS===========



void vertMouse(List<Vertex> lv) {
      Vertex v = new Vertex(mouseX, mouseY);
      for (Vertex w: lv) v.add(w);
      lv.add(v);
      v.print();
}
    
void vertGrid(List<Vertex> lv) {
    int n = 10;
    
    for (int i=0; i<n*n; i++) {
	Vertex v = new Vertex(width / (n-1) * (i%n), height/(n-1) * (i/n));
	for (Vertex w: lv) v.add(w);
	lv.add(v);
    }
}
