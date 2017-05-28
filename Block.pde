import java.util.*;

public class Block {
    List<Location> corners;

    public Block() {
	corners = new LinkedList<Location>();
    }
    
    public Block(Collection<Location> c) {
	this()
	for (Location l: c) {
	    corners.add(new Location(l));
	}
    }

    public Block(Collection<Vertex> c) {
	this();
	for (Vertex v: c) {
	    corners.add(v.location());
	}
    }
}
