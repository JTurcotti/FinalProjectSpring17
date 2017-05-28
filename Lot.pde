import java.util.*;

public class Lot {
    List<Location> corners;

    public Lot() {
	corners = new LinkedList<Location>();
    }
    
    public Lot(Collection<Location> c) {
	this()
	for (Location l: c) {
	    corners.add(new Location(l));
	}
    }

    public Lot(Collection<Vertex> c) {
	this();
	for (Vertex v: c) {
	    corners.add(v.location());
	}
    }
}
