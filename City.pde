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

    public City(Grid streets) {
	this.streets = streets;
	blocks = new TreeSet<Block>();  //need element access, perfomance decrease is ok because only run once
    }
    
    public Block blockFromVertex(Vertex v) {
	Vertex one = v;
	Vertex two = one.neighbors.get(0);
	
	Queue<Path> eval = new ArrayDeque<Path>();
	eval.add((new Path(null, one, one, 0).next(two)));
	Path p;

	do { //this searches breadth first, and is thus gauranteed to find a minimal polygon block
	    p = eval.remove();
	    for (Vertex w: p.head.neighbors)
		if (w!=p.prev.head)
		    eval.add(p.next(w));
	} while (!p.isCircular());
	
	Block b = new Block();

	for (Vertex w: p)
	    b.corners.add(w);
	b.normalize();
	return b;
    }
    
    //takes the grid of vertices and populates blocks with the blocks between them
    public void genBlocks() {
	for (Vertex v: streets.vertices()) {
	    Block b = blockFromVertex(v);
	    b.print(int(random(256)));
	    blocks.add(b);
	}
    }
}
	    
