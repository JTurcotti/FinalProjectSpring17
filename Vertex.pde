import java.util.*;

public class Vertex {
    int x;
    int y;
    List<Vertex> neighbors;

    int age; //number of growth cycles since creation
    
    public Vertex(int x, int y) {
	this.x = x;
	this.y = y;
	neighbors = new LinkedList<Vertex>();
	age = 0;
    }

    public Vertex(Vertex v) {
	this(v.x, v.y);
	v.add(this);
    }

    public void add(Vertex v) {
	v.neighbors.add(this);
	neighbors.add(v);
    }


    public void print() {
	for (Vertex n: neighbors)
	    line(this.x, this.y, n.x, n.y);
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
		    line(v.x, v.y, n.x, n.y);
		    eval.push(n);
		}
	    }
	}
    }
    
    /* 0-down
       1-right
       2-up
       3-left
    */
    public void push(int direction, int step) {
	if (direction > 1)
	    step *= -1;
	if (direction%2 == 0)
	    y += step;
	else
	    x += step;
    }

    @Override
    public String toString() {
	return "(" + this.x + ", " + this.y + ")";
    }

    @Override
    public boolean equals(Object o) {
	if (!(o instanceof Vertex)) return false;
	Vertex vo = (Vertex) o;
	return (vo.x == this.x) && (vo.y == this.y);
    }

    @Override
    public int hashCode() {
	return x<<16 + y;
    }
}
