import java.util.*;

List<Vertex> vis;


void setup() {
    size(1024, 1024);
    vis = new ArrayList<Vertex>();
}

void draw() {
  if (mousePressed) {
      fill(0);
  }
  ellipse(mouseX, mouseY, 80, 80);
}
