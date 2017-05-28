import java.util.*;

class Path implements Iterable<Vertex>{
    Path prev;
    Vertex head;
    Vertex tail;
    int size;

    public Path(Path prev, Vertex head, Vertex tail, int size) {
	this.prev = prev;
	this.head = head;
	this.tail = tail;
	this.size = size;
    }
    
    public Path next(Vertex v) { //extends the head, preserves the tail
	return new Path(this, v, tail, size++);
    }

    public boolean isCircular() {
	return head == tail;
    }

    //this iterator DOES NOT RETURN THE TAIL (yes thats intentional)
    @Override
    public Iterator<Vertex> iterator() {
	return new Iterator<Vertex>() {
	    Path p = Path.this;

	    public Vertex next() {
		Vertex v = p.head;
		p = p.prev;
		return v;
	    }

	    public boolean hasNext() {
		return p.prev!=null; //TAIL ISNT INCLUDED
	    }

	    public void remove() {
		throw new UnsupportedOperationException();
	    }
	};
    }

    public String toString() {
	String out = "";
	for (Vertex v: this)
	    out += v + "\n";
	out += "TAIL: " + tail;
	return out;
    }
}

public class City {
    Grid streets;
    TreeSet<Block> blocks;

    //takes the grid of vertices and populates blocks with the blocks between them
    public void genBlocks() {
	blocks = new TreeSet<Block>(); //need element access, perfomance decrease is ok because only run once

	Vertex one = streets.root;
	Vertex two = one.neighbors.get(0); //doesn't matter which neighbor

	Queue<Path> eval = new ArrayDeque<Path>();
	eval.add((new Path(null, one, one, 0).next(two)));
	Path p;

	do { //this searches breadth first, and is thus gauranteed to find a minimal polygon block
	    p = eval.remove();
	    for (Vertex v: p.head.neighbors)
		if (v!=p.prev.head)
		    eval.add(p.next(v));
	} while (!p.isCircular());
	
	Block first = new Block();
	
	for (Vertex v: p)
	    first.corners.add(v);
	first.normalize();
	println(first);
	blocks.add(first);
    }
}
	    
