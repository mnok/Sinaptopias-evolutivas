import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


Box2DProcessing box2d;
Body cuerpo;
BodyDef bd;
float w,h;

void setup(){
  size(800, 600);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(box2d.coordPixelsToWorld(width/2, height/2));
  cuerpo = box2d.createBody(bd);
  
  w = 16;
  h = 16;
 
  //Definimos la forma del cuerpo 
  PolygonShape cuad = new PolygonShape();
  float b2dw = box2d.scalarPixelsToWorld(w/2);
  float b2dh = box2d.scalarPixelsToWorld(w/2);
  cuad.setAsBox(b2dw, b2dh);

  //Definimos las características fisicas del objeto
  FixtureDef fd = new FixtureDef();  
  fd.shape = cuad;
  fd.density = 1;
  fd.friction = 0.3;
  fd.restitution = 0.5;
  cuerpo.createFixture(fd);
}

void draw(){
  box2d.step();
  Vec2 pos = box2d.getBodyPixelCoord(cuerpo);
  float a = cuerpo.getAngle();
  
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(-a);
  fill(0);
  rectMode(CENTER);
  rect(0,0, w, h);
  popMatrix();
}
