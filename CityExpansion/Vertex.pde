import java.util.*;

public class Vertex implements Comparable<Vertex> {
    Location loc; //current location
    LinkedList<Vertex> next;
    LinkedList<Vertex> prev;

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
	next = new LinkedList<Vertex>();
	prev = new LinkedList<Vertex>();
	age = 0;
    }

    public Vertex(Vertex v) {
	this(v.x(), v.y());
	this.prev.add(v);
	v.next.add(this);
	
    }

    public Vertex(Location l) {
	this(l.x, l.y);
    }

    public int size() {
	return next.size() + prev.size();
    }

    public void addBetween(Vertex v, Vertex w) {//v.next.contains(w) and w.prev.contains(v)
	v.next.remove(w);
	w.prev.remove(v);

	v.next.add(this);
	w.prev.add(this);

	this.next.add(w);
	this.prev.add(v);
    }

    public LinkedList<Vertex> neighbors() {
	LinkedList<Vertex> neighbors = new LinkedList<Vertex>();
	neighbors.addAll(prev);
	neighbors.addAll(next);
	return neighbors;
    }

    public void print() {
	for (Vertex n: neighbors())
	    line(this.x(), this.y(), n.x(), n.y());
    }
    
    public void printNet() { //prints network containing this node at center
	Stack<Vertex> eval = new Stack<Vertex>();
	eval.push(this);
	while (!eval.empty()) {
	    Vertex v = eval.pop();
	    for (Vertex n: v.next) {
		line(v.x(), v.y(), n.x(), n.y());
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
