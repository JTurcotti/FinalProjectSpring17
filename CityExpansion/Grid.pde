import java.util.*;

public class Grid {
    //list of 4 vertex queues, corresponding to the four directions (see Vertex)
    List<Queue<Vertex>> directions;
    
    //locations already included in this grid, maps locations to the vertex associated with them
    Set<Location> gridLocations;

    Set<Vertex> vertices;
    
    List<Vertex> fresh; //each grow cycle, stores new tips
    
    Vertex root;
    
    static final int step = 30;  //growth of brances each step
    static final float chance = 0.5;  //chance of sprouting new branch each step

    //null constructor for testing only, never use
    public Grid() {}
    
    public Grid(Vertex root) {
	directions = new ArrayList<Queue<Vertex>>();
	gridLocations = new HashSet<Location>();

	vertices = new HashSet<Vertex>();
	
	this.root = root;
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

    public Set<Vertex> movingTips() {
	Set<Vertex> set = new HashSet<Vertex>();
	for (Queue<Vertex> direction: directions)
	    set.addAll(direction);
	return set;
    }

    int x = 100; //set to 0, else for debugging
    
    //checks if the position of a vertex is unoccupied and within the viewing space
    private boolean valid(Vertex v) {
	return !present(v.loc) &&
	    v.x() < width - x &&
	    v.x() > 0 + x &&
	    v.y() < height - x &&
	    v.y() > 0 + x ;
    }

    //tests if grid is clear in a given direction for a given distance from v
    private boolean clearInDirection(int direction, int steps, Vertex v) {
	Location w = v.location();
	while (steps-->0) {
	    w.push(direction, step);
	    if (present(w))
		return false;
	}
	return true;
    }

    //non-deterministic, determines conditions to procedd tip in directiton without sprouting
    boolean proceed(int direction, Vertex tip) {
	return (random(1)>chance || //probably occurs
		tip.age++ < 2 || //or if too young to have a kid
		(tip.age > 100) && (tip.age<105) || //or if just had a kid
		tip.age >=1000 || //or if on edge
		!clearInDirection(direction, 2, tip)); //or if too close
    }


    List<Vertex> grow() { //returns moved/new Vertices
	fresh = new ArrayList<Vertex>();
	directions: for (int i=0; i<4; i++) {
	    Queue<Vertex> direction = directions.get(i);
	    tips: for (int j = direction.size(); j>0; j--) {
		Vertex tip = direction.remove(); //pull a tip
		
		if (proceed(i, tip)) {
			
		    //don't sprout new tip
		    for (int k=0; k<step; k++) {
			gridLocations.add(tip.location());
			tip.push(i, 1);
		    }
		    fresh.add(tip);

		    if (valid(tip))// if tip in a valid position
			direction.add(tip);// cycle back to end of queue
		    
			
		    gridLocations.add(tip.location());//then proceed to mark location invalid for future tipes
				    
		    
		} else {
		    //sprout new tips (3)
		    for (int k=0; k<4; k++)  { //directions
			if (i-k!=2 && k-i!=2) { //don't sprout in opposite of current direction
			    Queue<Vertex> direction2 = directions.get(k);
			    
			    Vertex tip2 = new Vertex(tip);
			    
			    if (i==k)
				tip2.age = 100; //the sprout that continues in the same direction skips a generation
			    
			    fresh.add(tip2);
			    vertices.add(tip2);
			    direction2.add(tip2);
			} //add a linked copy to each OTHER direction (old tip stops growing)
		    }
		}
	    }
	}
	return fresh;
    }

    boolean present(Location l) {
	return gridLocations.contains(l);
    }

    Vertex toVertices() {
	Vertex root = new Vertex(this.root.x(), this.root.y());

	Stack<Vertex> eval = new Stack<Vertex>();
	Map<Location, Vertex> positions = new HashMap<Location, Vertex>();
	eval.add(root);
	while(!eval.empty()) {
	    Vertex v = eval.pop();
	    ellipse(v.loc);
	    println("pulling " + v);
		
	    for (int dir=0; dir<4; dir++) {
		Location l = v.location();
		println("location at " + l + " in direction " + dir);
		boolean expandable = true;
		do {
		    if (!present(l.adjacent(dir))) {
			expandable = false;
			break;
		    }
		    l.push(dir, 1);
		    println("moving once to " + l);
		} while (!present(l.adjacent((dir + 1)%4)) &&
			 !present(l.adjacent((dir - 1)%4)));
		Vertex w;
		if (positions.containsKey(l))
		    w = positions.get(l);
		else {
		    w = new Vertex(l);
		    positions.put(l, w);
		    if (expandable) {
			eval.push(w);
			println("pushing " + w);
		    }
		}
		v.add(w);
		w.add(v);
	    }
	}
	println("done");
	return root;
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

