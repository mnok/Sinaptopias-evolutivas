import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


Box2DProcessing box2d;
Body cuerpo;
BodyDef bd;

Body piso;
BodyDef pd;

float w,h;

void setup(){
  size(800, 600);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
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
  
  pd = new BodyDef();
  pd.type = BodyType.STATIC;
  pd.position.set(box2d.coordPixelsToWorld(width/2, height - 20));
  piso = box2d.createBody(pd);
  
  //Definimos forma del piso
  PolygonShape ps = new PolygonShape();
  float b2dpw = box2d.scalarPixelsToWorld(width/4);
  float b2dph = box2d.scalarPixelsToWorld(10);
  ps.setAsBox(b2dpw, b2dph);
  
  piso.createFixture(ps,1);
}

void draw(){
  background(255);
  box2d.step();
  Vec2 cpos = box2d.getBodyPixelCoord(cuerpo);
  float a = cuerpo.getAngle();
    
  pushMatrix();
  translate(cpos.x, cpos.y);
  rotate(-a);
  fill(0);
  rectMode(CENTER);
  rect(0,0, w, h);
  popMatrix();
  
  rectMode(CENTER);
  rect(width/2, height - 20, width/2, 20);
  
  
}
