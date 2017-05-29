import java.util.*;

Grid g;
Vertex root;
int i;
boolean printing = true;
boolean colored = false;

void setup() {
    /*    Block b1 = new Block();
    b1.corners.add(v1);
    b1.corners.add(v2);
    b1.corners.add(v3);

    println(b1);
    b1.normalize();
    println(b1);
    
    Block b2 = new Block();
    b2.corners.add(v2);
    b2.corners.add(v1);
    b2.corners.add(v3);

    println(b2);
    b2.normalize();
    println(b2);

    println(b1.equals(b2));*/
    
    background(255);
    size(2048, 2048);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
    ellipseMode(RADIUS);
  }

void draw() {
    if (i++%5==0 && printing) growCycle();

    background(255);
    g.root.printNet();
    
    for (Vertex v: g.vertices()) {
	int s = v.neighbors.size();
	if (s==5)
	    fill(255, 255, 0); //Yellow
	else if (s==4)
	    fill(255, 0, 0); //Red
	else if (s==3)
	    fill(0, 255, 0); //Green
	else if (s==2)
	    fill(0, 0, 255); //Blue
	else if (s==1)
	    fill(0, 255, 255); //Cyan
	else if (s==0)
	    fill(0, 0, 0);
	else
	    fill(255, 0, 255); //Magenta
	ellipse(v.x(), v.y(), 5, 5);
    }
    
    
	
	/*	Location l = new Location(mouseX, mouseY);
	if (g.places.containsKey(l)) {
	    Vertex bar = g.places.get(l);
	    Vertex par = bar.neighbors.getFirst();
	    }*/
    
	       
}

void mouseReleased() {
    background(255);

    /*    printing = false;

    if (colored)
	g.root.printNet();
    else
	drawCity();
	colored = !colored;*/
}

void growCycle() {
    for (Vertex v: g.grow())
	v.print();
    println(g.size());
}

void drawCity() {
    City c = new City(g);
    c.genBlocks();
}


