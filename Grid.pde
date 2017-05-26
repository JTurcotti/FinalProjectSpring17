import java.util.*;

public class Grid {
    Queue<Vertex>[] buds;
    Vertex root;
    int step;
    int chance;

    public Grid(Vertex root) {
	this.root = root;
	buds = new Queue<Vertex>[] {
	    new ArrayDeque<Vertex>(),
		new ArrayDeque<Vertex>(),
		new ArrayDeque<Vertex>(),
		new ArrayDeque<Vertex>()};
	for (Queue<Vertex> bud: buds) {
	    Vertex v = new Vertex(root);
	    bud.add(v);
	}
	step = 5;
	chance = 0.1;
    }

    public void growBud() {
	for (int i=0; i<4; i++) {
	    Queue<Vertex> bud = buds[i];
	    for (int i = bud.size(); i>0; i--) {
		Vertex v = bud.remove();
		if (random(1)>chance) {
		    v.push(i, step);
		    bud.add(v);
		} else
		    for (Queue<Vertex> bud2: buds)
			   if (bud2 != bud) {
			       Vertex w = new Vertex(v);
			       bud2.add(w);
			   }
	    }
	}
    }
		
	    
	
    
    
