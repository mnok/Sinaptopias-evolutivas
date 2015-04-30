ArrayList shapes;

void setup() {
  size(800, 800);
 shapes = new ArrayList();
 
 
 for(int i=0; i < 7; i++){  
 Vertex myVertex = new Vertex (random(0, 55), random(0, 75));
 shapes. add(myVertex);
 }
 

}
void draw() {
  background(0);

  for(int i=0; i < shapes. size(); i++){
   Vertex mB = (Vertex) shapes.get(i);
   mB. display();
  }
}

class Vertex {
  PVector location;
  PVector[] q_pts;
  Vertex(float a, float b) {
    location = new PVector(a, b);
    q_pts=new PVector[7];
    construct();
  }
  
  void construct() {
    
    q_pts[0] = new PVector(random(0, 75), random(0, 90));
    q_pts[1] = new PVector(random(0, 75), random(0, 90));
    q_pts[2] = new PVector(random(0, 75), random(0, 90));
    q_pts[3] = new PVector(random(0, 75), random(0, 90)); 
    q_pts[4] = new PVector(random(0, 75), random(0, 90));
    q_pts[5] = new PVector(random(0, 75), random(0, 90));
    q_pts[6] = new PVector(random(0, 75), random(0, 90));
  }
  float getRealX() {
    return location.x;
  }
  
  float getRealY() {
    return location.y;
  }
  
  void display(){
    translate(location.x, location.y);
    beginShape(TRIANGLE_STRIP);
    vertex(q_pts[0].x, q_pts[0].y);
    vertex(q_pts[1].x, q_pts[1].y);
    vertex(q_pts[2].x, q_pts[2].y);
    vertex(q_pts[3].x, q_pts[3].y);
    vertex(q_pts[4].x, q_pts[4].y);
    vertex(q_pts[5].x, q_pts[5].y);
    vertex(q_pts[6].x, q_pts[6].y);
    endShape();
  }
  
}


