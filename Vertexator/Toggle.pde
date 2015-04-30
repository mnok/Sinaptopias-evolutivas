
class Toggle {
  PVector loc;
  
  boolean whichOne;
  String first;
  String second;
  
  float WIDTH;
  float HEIGHT;
  
  Toggle(int x, int y, String first, String second) {
    loc = new PVector(x, y);
    
    this.first = first;
    this.second = second;
    
    WIDTH = 22 + textWidth(first + second);
    HEIGHT = 10 + textAscent();
  }
  
  void update() {
    if(mousePressed && mouseX > loc.x - WIDTH / 2 && mouseX < loc.x + WIDTH / 2 && mouseY > loc.y - HEIGHT / 2 && mouseY < loc.y + HEIGHT / 2) whichOne = (mouseX >= loc.x - WIDTH / 2 + textWidth(first) + 10);
  }
  
  void display() {
    pushStyle();
    
    stroke(255);
    fill(0);
    
    rect(loc.x - WIDTH / 2, loc.y - HEIGHT / 2, WIDTH, HEIGHT);
    line(loc.x - WIDTH / 2 + textWidth(first) + 10 + 4, loc.y - HEIGHT / 2, loc.x - WIDTH / 2 + textWidth(first) + 10 - 4, loc.y + HEIGHT / 2);
    
    fill(255);
    textAlign(CENTER, CENTER);
    
    if(whichOne) fill(102);
    else fill(255);
    text(first, loc.x - WIDTH / 2 + 6 + textWidth(first) / 2, loc.y - 1);
    
    if(whichOne) fill(255);
    else fill(102);
    text(second, loc.x + WIDTH / 2 - 6 - textWidth(second) / 2, loc.y - 1);
    
    popStyle();
  }
}
