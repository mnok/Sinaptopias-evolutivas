//aLittleBitMore
//echoechonoisenoise 2010
//echo.link: this-yourWork-this
 
import toxi.processing.*;
import toxi.geom.mesh.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import processing.dxf.*;
//
//// agrego arduino
//
//import processing.serial.*;
//import cc.arduino.*;

// agrego kinect


boolean record =false ;
boolean animate=true;
WETriangleMesh mesh2;
int DIM = 10;//dimensions of the voxel space: 45x45x45 voxels
float ISO_THRESHOLD =0.5;//higher values smoothen the result, lower uncover spherical characteristics of volumebrush
Vec3D SCALE = new Vec3D(0.3,0.3,0.3).scaleSelf(2000);//proportions and scale of voxel space
VolumetricSpace volume2 = new VolumetricSpaceArray(SCALE,DIM,DIM,DIM);
;
IsoSurface surface2;
VolumetricBrush brush2;
float brushDensity=10;



WETriangleMesh mesh3;
int DIM2 = 15;//dimensions of the voxel space: 45x45x45 voxels
Vec3D SCALE2 = new Vec3D(1, 2, 1).scaleSelf(100);//proportions and scale of voxel space
VolumetricSpace volume3 = new VolumetricSpaceArray(SCALE2,DIM2,DIM2,DIM2);
;
IsoSurface surface3;
VolumetricBrush brush3;
float brushDensity2=10;





ArrayList ptc2;//particles list
int pAmount2=300;
ArrayList panels2;//panels list
float i2=random(90,100);//position in noise space, randomized, so each time different form comes out
float sc2=0.008;

int fcount2=0;


 
ArrayList ptc;//particles list
int pAmount=300;
ArrayList panels;//panels list
float i=random(90,100);//position in noise space, randomized, so each time different form comes out
float sc=0.008;
 
PVector l[];//lights stored as vectors
float str;
int fcount=0;
float atick=0;
 
 
PeasyCam cam;

////arduino
//
////DECLARAR VARIABLE
//Arduino arduino;
////SE DECLARA LA VARIABLE DEL PIN13
//int ledPin=13;
////SE DECLARA VARIABLE DEL ENCENDIDO QUE INCIA EN APAGADO
//boolean led=false;
//int col = 0;

boolean generar = false;
 
void setup() {
  size(1000,700,P3D);   
 // stroke(0);
  //strokeWeight(2.5);
  cam = new PeasyCam(this,450);
  cam.rotateX(PI*0.3);
  cam.rotateZ(PI*0.3);
  initLight();
 
 
  surface2=new HashIsoSurface(volume2);
  brush2=new RoundBrush(volume2,10);
  ptc=new ArrayList();
  for(int i=0;i<pAmount;i++) {
    ptc.add(new Particle());
  }
  panels=new ArrayList();
  
  
  surface3=new HashIsoSurface(volume3);
  brush3=new RoundBrush(volume3,10);
  ptc2=new ArrayList();
  for(int i=0;i<pAmount2;i++) {
    ptc2.add(new Particle());
  }
  panels2=new ArrayList();
  
//    // Prints out the available serial ports.
//  println(Arduino.list());
//  arduino = new Arduino(this, "COM3", 57600);
//  arduino.pinMode(ledPin, Arduino.OUTPUT);
//  arduino.digitalWrite(ledPin, Arduino.HIGH);
//
//  // Set the Arduino digital pins as inputs.
//  for (int i = 0; i <= 13; i++){
//    arduino.pinMode(i, Arduino.INPUT);
//  }
//  
}
 
void draw() {
  background(0);
  for(int i=0; i<l.length; i++) {
    directionalLight(str,str,str, l[i].x,l[i].y,l[i].z);//all the lights
  }
  if (record == true) {
    beginRaw(DXF, "shapes/shape-####.dxf");
  }
  if(generar){
  if(fcount<=100) {//record 30 steps as a shape, each time updating the isosurface
    volume2.closeSides(); 
    surface2.reset();
    mesh2 = new WETriangleMesh();
    surface2.computeSurfaceMesh(mesh2,ISO_THRESHOLD);
    new LaplacianSmooth().filter(mesh2, 1);
    for(int i=1;i<ptc.size();i++) {
      Particle c=(Particle)ptc.get(i);
      c.behave();//move particle around
      c.display();//draw it's trace using volumetric brush
    }
    panels.clear();
    int num=mesh2.getNumFaces();
    Vec3D[] verts=null;
    for(int i=0; i<num; i++) {
      Face f=mesh2.faces.get(i);
      PVector a=new PVector(f.a.x,f.a.y,f.a.z);
      PVector b=new PVector(f.b.x,f.b.y,f.b.z);
      PVector c=new PVector(f.c.x,f.c.y,f.c.z);
      panels.add(new TriangularPanel(a,b,c));
    }
  }
  for(int i=0;i<panels.size();i++) {
    TriangularPanel p=(TriangularPanel) panels.get(i);
    if(animate)p.construct();
    p.display();
  }
  if (record == true) {
    endRaw();
    record = false; // Stop recording to the file
  }
  fcount++;
  }
  if(animate)atick+=0.0999989;
  
  
  
  
  
   if(fcount2<=100) {//record 30 steps as a shape, each time updating the isosurface
    volume3.closeSides(); 
    surface3.reset();
    mesh3 = new WETriangleMesh();
    surface3.computeSurfaceMesh(mesh3,ISO_THRESHOLD);
    new LaplacianSmooth().filter(mesh3, 1);
    for(int i=1;i<ptc2.size();i++) {
      Particle c2=(Particle)ptc2.get(i);
      c2.behave();//move particle around
      c2.display();//draw it's trace using volumetric brush
    }
    panels2.clear();
    int num2=mesh3.getNumFaces();
    Vec3D[] verts=null;
    for(int i=0; i<num2; i++) {
      Face f=mesh3.faces.get(i);
      PVector a2=new PVector(f.a.x,f.a.y,f.a.z);
      PVector b2=new PVector(f.b.x,f.b.y,f.b.z);
      PVector c2=new PVector(f.c.x,f.c.y,f.c.z);
      panels2.add(new TriangularPanel(a2,b2,c2));
    }
  }
  for(int i=0;i<panels2.size();i++) {
    TriangularPanel p2=(TriangularPanel) panels2.get(i);
    if(animate)p2.construct();
    p2.display();
  }
  fcount2++;
  
  
  
  
  
//   for (int i = 0; i <= 5; i++) {
//   col = arduino.analogRead(i) /4 ;//regulates color of each segment
//   //println(col);
//   }
   
}
 
void keyPressed() {
  if(key=='a') {//move panels, change colors
    animate=!animate;
  }
  if(key==' ') {//reset all the stuff, and create a new shape
    fcount=0;
    atick=0;
    i=random(100);
    DIM = (int)random(10, 35);
    volume2=new VolumetricSpaceArray(SCALE,DIM,DIM,DIM); 
    surface2=new HashIsoSurface(volume2);
    brush2=new RoundBrush(volume2,10);
    ptc=new ArrayList();
    for(int i=0;i<pAmount;i++) {
      ptc.add(new Particle());
    }
  }
  if(key=='d'){
    generar = true;
  }
  if(key=='r') {//save to dxf
    new LaplacianSmooth().filter(mesh2, 1);
    panels.clear();
    int num=mesh2.getNumFaces();
    Vec3D[] verts=null;
    for(int i=0; i<num; i++) {
      Face f=mesh2.faces.get(i);
      PVector a=new PVector(f.a.x,f.a.y,f.a.z);
      PVector b=new PVector(f.b.x,f.b.y,f.b.z);
      PVector c=new PVector(f.c.x,f.c.y,f.c.z);
      panels.add(new TriangularPanel(a,b,c));
    }
  }
}
 
void initLight() {//by Marius Watz
  randomSeed(11);
  l=new PVector[7];
  for(int i=0; i<l.length; i++) {
    str=random(TWO_PI);
    l[i]=new PVector(cos(str)*10,0.3,sin(str)*10);
  }
  str=random(120,180);
}

