import java.util.*;

Grid g;
Vertex root;
int i;
boolean printing = false;
boolean showing = false;

Map<Vertex, Integer> colors;

void setup() {
    background(255);
    size(2048, 2048);
    root = new Vertex(width/2, height/2);
    g = new Grid(root);
    ellipseMode(RADIUS);
    printing = true;
}

void draw() {
    if (printing) {
	background(255);
	g.print();
	println("just printed map");
	if (i++%1==0) growCycle();



	/*for (Vertex v: g.vertices()) {
	    int s = v.size();
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
		fill(0, 0, 0); //BLACK
	    else
		fill(255, 0, 255); //Magenta
	    ellipse(v.loc);
	    }*/

	
    }
	
	
	
}

void illuminate() {
    printing = false;
    showing = false;

    background(0);
    println("background cleared");

    for (int x=0; x<width; x++) {
	for (int y=0; y<height; y++) {
	    Location l = new Location(x, y);
	    println(l);
	    delay(1);
	    if (g.places.containsKey(l)) {
		stroke(255, 0, 0);
		point(l.x, l.y);
	    }
	}
    }

    println("C");
}

void killuminate() {
    printing = false;
    showing = false;


    background(255);

    g.print();
    println("grid printed and terminated ");

    colors = new HashMap<Vertex, Integer>();
    
    for (Vertex v: g.vertices()) {
	color c = color(int(random(256)), int(random(256)), int(random(256)));
	colors.put(v, c);
	fill(c);
	ellipse(v.loc);
    }

    println("vertex colors initiliazed");

    for (int x=0; x<width; x++) {
	for (int y=0; y<height; y++) {
	    Location l = new Location(x, y);
	    if (g.places.containsKey(l)) {
		stroke(colors.get(g.places.get(l)));
		point(l.x, l.y);
	    }
	}
    }
    println("did that too");
}

void growCycle() {
    for (Vertex v: g.grow())
	v.print();
    if (g.size()==0)
	illuminate();
}

void drawCity() {
    City c = new City(g);
    c.genBlocks();
}



//testing
void ellipse(Location l) {
    ellipse(l.x, l.y, 5, 5);
}


