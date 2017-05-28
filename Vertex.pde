import java.util.*;

public class Vertex implements Comparable<Vertex> {
    Location loc; //current location
    LinkedList<Vertex> neighbors;
    Vertex parent; //only non-null if created with Vertex(Vertex) constructor

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
	add(v);
	parent = v;
    }

    public Vertex(Location l) {
	this(l.x, l.y);
    }

    //note the following two methods link/unlink in both directions
    public void add(Vertex v) {
	v.neighbors.add(this);
	neighbors.add(v);
    }

    public void remove(Vertex v) {
	v.neighbors.remove(this);
	neighbors.remove(v);
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

    //following methods come from wrapped location
    
    @Override
    public String toString() {
	return loc.toString();
    }

    @Override
    public boolean equals(Object o) {
	return loc.equals(o);
    }

    @Override
    public int hashCode() {
	return loc.hashCode();
    }

    @Override
    public int compareTo(Vertex other) {
	return loc.compareTo(other.loc);
    }

    public void push(int direction, int step) {
	loc.push(direction, step);
    }

}
