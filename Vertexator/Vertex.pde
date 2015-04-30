
class Vertex {
  PVector location;
  boolean selected;
  
  PVector pressLoc;
  
  Vertex() {
    location = new PVector(mouseX, mouseY);
    selected = true;
  }
  
  Vertex(float x, float y) {
    location = new PVector(x, y);
  }
  
  float getRealX() {
    return location.x - 80;
  }
  
  float getRealY() {
    return location.y - 80;
  }
  
  boolean update() {
    if(mode == SELECT) pressLoc = new PVector(mouseX - location.x, mouseY - location.y);
    
    if(mode == SELECT && dist(mouseX, mouseY, location.x, location.y) < 10) {
      selected = true;
      
      return true;
    } else {
      selected = false;
      return false;
    }
  }
  
  boolean checkUpdateSelection() {
    PVector test = new PVector(mouseX - pressLoc.x, mouseY - pressLoc.y);
    
    if(test.x < 80 || test.x > width - 80 || test.y < 80 || test.y > height - 80) return false;
    else return true;
  }
  
  void updateSelection() {
    location.x = (mouseX - pressLoc.x);
    location.y = (mouseY - pressLoc.y);
  }
  
  void press() {
    
  }
  
  void display() {
    pushStyle();
    
    if(selected) {
      displayHighlight();
    }
    
    noStroke();
    fill(255);
    
    ellipse(location.x, location.y, 5, 5);
    
    popStyle();
  }
  
  void displayHighlight() {
    fill(255, 102);
    noStroke();
    
    ellipse(location.x, location.y, 10, 10);
  }
  
  String getOutput() {
    return "vertex(" + (location.x - 80) + ", " + (location.y - 80) + ");";
  }
}
