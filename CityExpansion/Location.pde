import java.util.*;

public class Location implements Comparable<Location> {
    int x, y;

    public Location(int x, int y) {
	this.x = x;
	this.y = y;
    }

    public Location(Location l) {
	this(l.x, l.y);
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

    public Location adjacent(int direction) {
	Location l = new Location(this);
	l.push(direction, 1);
	return l;
    }

    public double distance(Location other) {
	return Math.pow(((this.x - other.x)*(this.x - other.x)+(this.y - other.y)*(this.y - other.y)), 0.5);
    }

    @Override
    public String toString() {
	return "(" + this.x + ", " + this.y + ")";
    }

    @Override
    public boolean equals(Object o) {
	if (!(o instanceof Location)) return false;
	Location l = (Location) o;
	return (l.x == this.x) && (l.y == this.y);
    }

    @Override
    public int hashCode() {
	return x<<16 + y;
    }

    @Override
    public int compareTo(Location other) {
	return hashCode() - other.hashCode();
    }

    public void print() {
	ellipseMode(RADIUS);
	fill(255, 0, 0);
	ellipse(x, y, 5, 5);
    }
}
