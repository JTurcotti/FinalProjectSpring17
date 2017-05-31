import java.util.*;

public class Vertex implements Comparable<Vertex> {
    Location loc; //current location
    Set<Vertex> next;

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
	next = new HashSet<Vertex>();
	age = 0;
    }

    public Vertex(Vertex v) {
	this(v.x(), v.y());
	v.add(this);
    }

    public Vertex(Location l) {
	this(l.x, l.y);
    }

    public int size() {
	return next.size();
    }

    void add(Vertex v) {
	next.add(v);
    }
    
    public void printNet() { //prints network containing this node at center
	Stack<Vertex> eval = new Stack<Vertex>();
	Set<Vertex> visited = new HashSet<Vertex>();
	eval.push(this);
	while (!eval.empty()) {
	    Vertex v = eval.pop();
	    visited.add(v);
	    for (Vertex n: v.next) {
		line(v.x(), v.y(), n.x(), n.y());
				    
		if (!visited.contains(n))
		    eval.push(n);
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

    public double distance(Vertex other) {
	return loc.distance(other.loc);
    }

}
