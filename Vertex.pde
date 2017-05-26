import java.util.*;

public class Vertex {
    int x;
    int y;
    List<Vertex> neighbors;
    
    public Vertex(int x, int y) {
	this.x = x;
	this.y = y;
	neighbors = new LinkedList<Vertex>();
    }

    public Vertex(Vertex v) {
	this(v.x, v.y);
	neighbors.add(v);
    }

    public void add(Vertex v) {
	v.neighbors.add(this);
	neighbors.add(v);
    }

    public void print() {
	Set<Vertex> visited = new HashSet<Vertex>();
	Stack<Vertex> eval = new Stack<Vertex>();
	eval.push(this);
	while (!eval.empty()) {
	    Vertex v = eval.pop();
	    println(" visited (" + v.x + ", " + v.y + ")");
	    visited.add(v);
	    for (Vertex n: v.neighbors) {
		if (!visited.contains(n)) {
		    line(v.x, v.y, n.x, n.y);
		    eval.push(n);
		}
	    }
	}
    }

    public void push(int direction, int step) {
	if (direction > 1)
	    step *= -1;
	if (direction%2 == 0)
	    x += step;
	else
	    y += step;
    }
}
