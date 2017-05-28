import java.util.*;

public class Grid {
    //list of 4 vertex queues, corresponding to the four directions (see Vertex)
    List<Queue<Vertex>> directions;
    
    //locations already included in this grid
    Set<Location> occupied;
    
    //actual Vertex instances
    List<Vertex> vertices;
    
    Vertex root;
    
    static final int step = 10;  //growth of brances each step
    static final float chance = 0.5;  //chance of sprouting new branch each step
    
    public Grid(Vertex root) {
	this.root = root;
	directions = new ArrayList<Queue<Vertex>>();
	occupied = new HashSet<Location>();
	vertices = new LinkedList<Vertex>();
	vertices.add(root);
	for (int i=0; i<4; i++) {
	    Queue<Vertex> direction = new ArrayDeque<Vertex>();
	    directions.add(direction);
	    Vertex v = new Vertex(root);
	    direction.add(v);
	    vertices.add(v);
	} //creates direction queues, each with one linked copy of the root

	println("grid constructed");
    }

    //checks if the position of a vertex is unoccupied and within the viewing space
    private boolean valid(Vertex v) {
	return !occupied.contains(v.loc) &&
	    v.x() < width &&
	    v.x() > 0 &&
	    v.y() < height &&
	    v.y() > 0;
    }

    //tests if grid is clear in a given direction for a given distance from v
    private boolean clearInDirection(int direction, int dist, Vertex v) {
	Location w = v.location();
	while (dist-->0) {
	    w.push(direction, 1);
	    if (occupied.contains(w))
		return false;
	}
	return true;
    }
    
    List<Vertex> grow() { //returns moved/new Vertices
	List<Vertex> fresh = new ArrayList<Vertex>();
	
	directions: for (int i=0; i<4; i++) {
	    Queue<Vertex> direction = directions.get(i);
	    tips: for (int j = direction.size(); j>0; j--) {
		Vertex tip = direction.remove(); //pull a tip

		if (random(1)>chance || //probably occurs
		    tip.age++ < 2 || //or if too young
		    !clearInDirection(i, step*2, tip)) { //or if too close
		    
		    //don't sprout new tip
		    tip.push(i, step);
		    fresh.add(tip);
		    
		    if (valid(tip))// if tip in a valid position
			direction.add(tip);// cycle back to end of queue
		    
		    
		} else {
			//sprout new tips (3)
		    for (int k=0; k<4; k++)  { //directions
			if (i-k!=2 && k-i!=2) { //don't sprout in opposite of current direction
			    Queue<Vertex> direction2 = directions.get(k);
			    
			    Vertex tip2 = new Vertex(tip);
			    fresh.add(tip2);
			    direction2.add(tip2);
			    vertices.add(tip2);
			} //add a linked copy to each OTHER direction (old tip stops growing)
		    }
		}
	    }
	}
	
	for (Vertex tip: fresh)
	    //mark new tips as occupied
	    occupied.add(tip.location());
	
	return fresh;
    }
    
    public void print() {
	root.printNet();
    }
    
    public int size() {
	int size = 0;
	for (Queue<Vertex> q: directions)
	    size += q.size();
	return size;
    }

}

