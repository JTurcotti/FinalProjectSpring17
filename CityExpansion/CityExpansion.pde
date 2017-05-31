import java.util.*;

Grid g;
Vertex root;
int i;
boolean printing = false;
boolean showing = false;

void setup() {
    background(255);
    size(512, 512);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
    ellipseMode(RADIUS);
    printing = true;
}

void draw() {
    if (printing) {
	background(255);
	g.print();
	if (i++%1==0) g.grow();
	if (g.size()==0) {
	    printing = false;

	    println("A");
	    printing = false;
	    Vertex v = g.toVertices();
	    println("B");
	    stroke(0, 255, 0);
	    v.printNet();
	    println("C");
	}
    }
}




void drawCity() {
    City c = new City(g);
    c.genBlocks();
}



//testing
void ellipse(Location l) {
    fill(0);
    ellipse(l.x, l.y, 10, 10);
}


