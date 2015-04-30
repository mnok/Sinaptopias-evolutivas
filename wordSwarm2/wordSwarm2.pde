/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/65606*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/30751*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
import toxi.processing.*;
import toxi.geom.*;
import geomerative.*;

PrintWriter output1;
PrintWriter output2;
vWorld world1;
ToxiclibsSupport gfx;
RFont font;

float envSize;

int w = 600;
int h = 300;
int tranX = w/2;
int tranY = h*3/5;

int rad = 6;

RPoint[] pnts;

void setup(){
  size(600,300);
  smooth();
  envSize = w/2;

  gfx=new ToxiclibsSupport(this);
  world1 = new vWorld();
  
  RG.init(this);
  font = new RFont( "tahoma.ttf", 80, RFont.CENTER);
  RGroup grp = font.toGroup("N T T");
  pnts = grp.getPoints();
  
  // create agents
  for (int i = 0; i < 800; i++) {
    world1.addAgent(new vAgentPrey(new Vec2D(random(width),random(height)), new Vec2D(random(-1,1),random(-1,1)), 20, 0.1));
  }
  
  for ( int i = 1; i < pnts.length; i+=2 ){
      world1.addAgent(new vAgentPredator(new Vec2D(pnts[i].x+tranX,pnts[i].y+tranY), new Vec2D(0,0), 0, 0));
  }
}


void draw(){
  background(0);
  world1.run();
  
  /*
  for ( int i = 1; i < pnts.length; i+=5 ){
      noFill();
      ellipse(pnts[i].x+tranX, pnts[i].y+tranY, 20, 20);
  }
  */
}

void mousePressed(){
  //writeText();
}

void writeText(){
  output1 = createWriter("positions.txt"); 
  output2 = createWriter("vectors.txt"); 
  
  for(int i =0 ;i<world1.population.size(); i++){
    vAgent a = (vAgent)world1.population.get(i);
    if(a.agentType=="vAgentPrey"){
      //println(a.pos.x +","+ a.pos.y +","+ a.vel.x +","+ a.vel.y);
      output1.println(a.pos.x +","+ (-a.pos.y) +","+ a.vel.x +","+ a.vel.y); 
    }
    if(a.agentType == "vAgentPredator"){
      output2.println(a.pos.x+","+ (-a.pos.y) +","+rad);
    }
  }
  
  output1.flush(); // Writes the remaining data to the file
  output1.close(); // Finishes the file
  output2.flush(); // Writes the remaining data to the file
  output2.close(); // Finishes the file
}
