import java.util.*;

public class Vertex {
    Location loc; //current location
    List<Vertex> neighbors;

    int age; //number of growth cycles since creation

    public int  x() {return loc.x;}
    public int  y() {return loc.y;}
    public void x(int x) {loc.x = x;}
    public void y(int y) {loc.y = y;}

    public Location location() {//copy of current location
	return new Location(x(), y());
    }
    
    public Vertex(int x, int y) {
	loc = new Location(x, y);
	neighbors = new LinkedList<Vertex>();
	age = 0;
    }

    public Vertex(Vertex v) {
	this(v.x(), v.y());
	v.add(this);
    }

    public void add(Vertex v) {
	v.neighbors.add(this);
	neighbors.add(v);
    }


    public void print() {
	for (Vertex n: neighbors)
	    line(this.x(), this.y(), n.x(), n.y());
    }
    
    public void printNet() { //prints network containing this node. Possiblely faster implemenation
	Set<Vertex> visited = new HashSet<Vertex>();
	Stack<Vertex> eval = new Stack<Vertex>();
	eval.push(this);
	while (!eval.empty()) {
	    Vertex v = eval.pop();
	    visited.add(v);
	    for (Vertex n: v.neighbors) {
		if (!visited.contains(n)) {
		    line(v.x(), v.y(), n.x(), n.y());
		    eval.push(n);
		}
	    }
	}
    }

    @Override
    public String toString() {
	return loc.toString();
    }

    public void push(int direction, int step) {
	loc.push(direction, step);
    }

}
