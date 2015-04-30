/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/60524*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;

PFont font;

ArrayList<Shape> shapes;
int selectedShape;

int mode;
final int ADD = 0;
final int SELECT = 1;

Toggle modeToggler;

void setup() {
  size(800, 800);
  
  ellipseMode(CENTER);
  smooth();
  
  font = createFont("Arial", 11);
  textFont(font);
  
  modeToggler = new Toggle(width / 2, height - 40, "DRAW", "SELECT");
  
  shapes = new ArrayList<Shape>();
}

void draw() {
  background(0);
  
  drawGrid();
  
  for(int i = 0; i < shapes.size(); i ++) {
    shapes.get(i).display();
  }
  
  modeToggler.update();
  modeToggler.display();
  
  if(modeToggler.whichOne) mode = SELECT;
  else mode = ADD;
  
  fill(255);
  textAlign(CENTER, CENTER);
  
  if(currentShape() >= 0 && shapes.get(currentShape()).currentVertex() >= 0) {
    PVector tempLoc = shapes.get(currentShape()).vertices.get(shapes.get(currentShape()).currentVertex()).location;
    
    text("Selected Vertex: " + constrain((int) tempLoc.x - 80, 0, 640) + ", " + constrain((int) tempLoc.y - 80, 0, 640) + "\nMouse: " + constrain(mouseX - 80, 0, 640) + ", " + constrain(mouseY - 80, 0, 640), width / 2, 40);
  } else text("Mouse: " + constrain(mouseX - 80, 0, 640) + ", " + constrain(mouseY - 80, 0, 640), width / 2, 40);
}

void drawGrid() {
  stroke(255, 51);
  
  int off = 80;
  int spacing = 10;
  
  for(int i = off; i <= min(width, height) - off; i += spacing) {
    line(i, off, i, height - off);
    line(off, i, width - off + (i == min(width, height) - off ? 1 : 0), i);
  }
}

void mousePressed() {
  for(int i = 0; i < shapes.size(); i ++) {
    if(shapes.get(i).update()) return;
  }
  
  if(mode == ADD && mouseInGrid()) shapes.add(new Shape());
}

void mouseDragged() {
  if(mode == SELECT && currentShape() >= 0) {
    if(shapes.get(currentShape()).currentVertex() >= 0) shapes.get(currentShape()).vertices.get(shapes.get(currentShape()).currentVertex()).updateSelection();
    else shapes.get(currentShape()).updateSelection();
  }
}

void mouseReleased() {
  for(int i = 0; i < shapes.size(); i ++) shapes.get(i).release();
}

void keyPressed() {
  if(key == ENTER && currentShape() != -1) shapes.get(currentShape()).turnOffSelection();
  if((key == BACKSPACE || key == DELETE) && currentShape() != -1) {
    if(mode == ADD || (mode == SELECT && shapes.get(currentShape()).currentVertex() >= 0)) shapes.get(currentShape()).removeVertex(shapes.get(currentShape()).currentVertex());
    else if(mode == SELECT) shapes.remove(currentShape());
  }
  
  if(key == ' ') {
    copyToClipboard(getOutput());
  }
  
  if(key == '1') {
    mode = ADD;
    modeToggler.whichOne = false;
  }
  if(key == '2') {
    mode = SELECT;
    modeToggler.whichOne = true;
  }
  
  if(currentShape() >= 0) {
    if(shapes.get(currentShape()).currentVertex() >= 0) {
      if(keyCode == RIGHT || keyCode == DOWN) {
        int tempVertex = (shapes.get(currentShape()).currentVertex() + 1) % shapes.get(currentShape()).vertices.size();
        
        shapes.get(currentShape()).turnOffVertexSelection();
        shapes.get(currentShape()).vertices.get(tempVertex).selected = true;
      }
      if(keyCode == LEFT || keyCode == UP) {
        int tempVertex = shapes.get(currentShape()).currentVertex() - 1;
        if(tempVertex < 0) tempVertex = shapes.get(currentShape()).vertices.size() - 1;
        
        shapes.get(currentShape()).turnOffVertexSelection();
        shapes.get(currentShape()).vertices.get(tempVertex).selected = true;
      }
    } else {
      if(keyCode == RIGHT || keyCode == DOWN) {
        int tempShape = (currentShape() + 1) % shapes.size();
        
        disableSelection();
        shapes.get(tempShape).selected = true;
      }
      if(keyCode == LEFT || keyCode == UP) {
        int tempShape = currentShape() - 1;
        if(tempShape < 0) tempShape = shapes.size() - 1;
        
        disableSelection();
        shapes.get(tempShape).selected = true;
      }
    }
  }
}

int currentShape() {
  for(int i = 0; i < shapes.size(); i ++) {
    if(shapes.get(i).selected) {
      return i;
    }
  }
  return -1;
}

boolean mouseInGrid() {
  if(mouseX > 80 && mouseX < width - 80 && mouseY > 80 && mouseY < height - 80) return true;
  else return false;
}

void disableSelection() {
  for(int i = 0; i < shapes.size(); i ++) shapes.get(i).turnOffSelection();
}

String getOutput() {
  String output = "";
  for(int i = 0; i < shapes.size(); i ++) output += shapes.get(i).getOutput() + "\n\n";
  return output;
}

void copyToClipboard(String text) {
  StringSelection copy = new StringSelection(text);
  Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copy, null);
}
