/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/53493*@*
 * SPECULATIVE APPS 001: 'saturation' by echoechonoisenoise
 * Shane Nelson's http://www.openprocessing.org/visuals/?visualID=49742
 * 3d Belousov-Zhabotinsky reaction _ Tommaso Casucci
 * http://www.openprocessing.org/visuals/?visualID=38850
 * expansion of Alasdair Turner code
 * http://www.openprocessing.org/visuals/?visualID=1263
 * echoechonoisenoise 2010
 * echo.link: this-yourWork-this
 * Copyright (C) 2014  Thomas Sanchez Lengeling.
 * KinectPV2, Kinect one library for processing
 * Copyright (C) 2015 Sinaptopias evolutivas  <http://godww7.wix.com/paisajes-evolutivos2/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import toxi.processing.*;
import toxi.geom.mesh.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import processing.dxf.*;
import controlP5.*;

// agrego kinect

import java.nio.FloatBuffer;
import KinectPV2.KJoint;
import KinectPV2.*;
import javax.media.opengl.GL2;

// agrego arduino

import processing.serial.*;

PeasyCam cam;

ToxiclibsSupport gfx;
float flechaTemp = 2050;
int generation = 1;
int pobla = 1;
int dimX = 35;
int dimY = 70;
int dimZ = 35;

int scs=100;
float ISO_THRESHOLD = 0.5;
Vec3D sc=new Vec3D(1, 2, 1).scaleSelf(scs);
VolumetricSpaceArray volume=new VolumetricSpaceArray(sc, dimX, dimY, dimZ);
IsoSurface surface=new HashIsoSurface(volume);
WETriangleMesh mesh;

int rFreq = 10;
int gFreq = 9;
int bFreq = 9;

int rIntens =255;
int gIntens =255;
int bIntens =255;

int bcgColor=120;

float [][][][] a;
float [][][][] b;
float [][][][] c;

int p = 0, q = 1;

boolean runReaction=false;
boolean uniform=true;

/**********************
**      kinect       **
**********************/

KinectPV2 kinect;

Skeleton [] skeleton;

/*
JointType_SpineBase     = 0;
 JointType_SpineMid      = 1;
 JointType_Neck          = 2;
 JointType_Head          = 3;
 JointType_ShoulderLeft  = 4;
 JointType_ElbowLeft     = 5;
 JointType_WristLeft     = 6;
 JointType_HandLeft      = 7;
 JointType_ShoulderRight = 8;
 JointType_ElbowRight    = 9;
 JointType_WristRight    = 10;
 JointType_HandRight     = 11;
 JointType_HipLeft       = 12;
 JointType_KneeLeft      = 13;
 JointType_AnkleLeft     = 14;
 JointType_FootLeft      = 15;
 JointType_HipRight      = 16;
 JointType_KneeRight     = 17;
 JointType_AnkleRight    = 18;
 JointType_FootRight     = 19;
 JointType_SpineShoulder = 20;
 JointType_HandTipLeft   = 21;
 JointType_ThumbLeft     = 22;
 JointType_HandTipRight  = 23;
 JointType_ThumbRight    = 24;
 */
// escala
float enx = width/65;
float eny = height/55;
float aaa = 0;
int zval = 0;
float scaleVal = 15;

//Distance Threashold distancia de captura 
float maxD = 10.0f; //meters
float minD = 0.3f;

// reconocimiento del cuerpo 


float rotX = PI;


// timer

boolean skeletonactive = true;
boolean timer2 = true;
boolean activsis = true;

float xx = 0.7;
float yy = 0.45;
ControlP5 cp5;

int savedTime2 = 0;
int totalTime2 = 5000;

int opacidad = 254;


/*************************
**  segunda simulacion  **
**************************/

boolean record =false ;
boolean animate=true;
WETriangleMesh mesh2;
int DIM = 28;//dimensions of the voxel space: 45x45x45 voxels
Vec3D SCALE = new Vec3D(0.3,0.3,0.3).scaleSelf(2000);//proportions and scale of voxel space
VolumetricSpace volume2 = new VolumetricSpaceArray(SCALE,DIM,DIM,DIM);
;
IsoSurface surface2;
VolumetricBrush brush2;
float brushDensity=10;

WETriangleMesh mesh3;
int DIM2 = 15;//dimensions of the voxel space: 45x45x45 voxels
Vec3D SCALE2 = new Vec3D(1, 2, 1).scaleSelf(110);//proportions and scale of voxel space
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
 
PVector l[];//lights stored as vectors
float str;
int fcount=0;
float atick=0;

/**********************
**     aparecer      **
**********************/

boolean aparecer = true;
boolean aparecer2 = true;
boolean aparecer3 = false;
boolean selecTime = true;
boolean timer3 = true;

int savedTime3 = 0;
int totalTime3 = 15000;
int check = 1;

/**********************
**      arduino      **
**********************/

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

void setup () {
  size(1200, 900, P3D);
//  cam = new PeasyCam(this, 250);
//  cam.rotateX(0.7);
//  cam.rotateY(0.45);
//  cam.rotateZ(-0.17);
  
  cam = new PeasyCam(this,450);
  cam.rotateX(PI*0.3);
  cam.rotateZ(PI*0.3);
  cp5 = new ControlP5(this);
 // initLight();
 
  Controller mySlider1 = cp5.addSlider("scaleVal", 0, 40, 15, 20, 200, 10);
  Controller mySlider2 = cp5.addSlider("enx", 0, 200, 15, 40, 200, 10);
  Controller mySlider3 = cp5.addSlider("eny", 0, 1, 15, 60, 200, 10);
  Controller mySlider4 = cp5.addSlider("zval", 0, 200, 15, 80, 200, 10);
  cp5.setAutoDraw(false);
  //initGUI();

  initMeshColors();
  initReaction();
  for (int i=0;i<50;i++)updateReaction();
  updateMesh();
  updateColors();
  for (int i=0;i<4;i++)new LaplacianSmooth().filter(mesh, 2);
  
  /*************************
  **  segunda simulacion  **
  **************************/
  
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
  
  /**********************
  **      kinect       **
  **********************/
  
  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  kinect.activateRawDepth(true);
  
  kinect.enableSkeleton(true );
  kinect.enableSkeletonDepthMap(true);
  kinect.enableBodyTrackImg(true );
  
  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);

  kinect.init();
  
  /**********************
  **      arduino      **
  **********************/
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);

}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void draw () {
  background(bcgColor);
  rotateX(xx);
  rotateY(yy); // roto todo porque no se como rotar el pesay cam
  pointLight(255, 255, 255, 300, -400, 300);
  pointLight(155, 155, 155, -300, -200, -300);
  pointLight(200, 200, 220, 300, 500, -300);
  gui();
 
if(aparecer){
    drawFilledMesh();
    translate(-scs/2, 0, -scs/2);
  for (int y=0; y < dimY; y++) {
    pushMatrix();
    translate(0, map(y, 0, dimY, -scs, scs), 0);
    scale(2.9);//very amateur way... didn't spent time on translating Shane's code into toxi.geom.mesh; although would be great to make further operations with it...
    if (y % floorDensity == 0 && y != 0 && y != dimY){
    drawSlice(input, y);
    }
    popMatrix();
  }
  if (runReaction) {
    updateReaction();
    updateMesh();
    updateColors();
  }
}

 
  /*************************
  **  segunda simulacion  **
  **************************/
if (aparecer3){  
  noStroke(); 
  translate(scs/2, 0, scs/2);
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
  
  fcount++;
}
  if(animate)atick+=0.0999989;
  
if(aparecer2){  
 noStroke();  
  translate(scs/2, 0, scs/2);
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
    }  
  
  /**********************
  **      kinect       **
  **********************/
  
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  //stroke(300);
  
  image(kinect.getBodyTrackImage(), 1000, 0, 200, 200);
  //image(kinect.getDepthImage(), 0, 0, 320, 240);
  fill(255, 0, 0);
  textSize(32);
  String myText = "Poblacion por hibridacion: " + pobla;
  String myText2 = "Flecha de Tiempo: " + flechaTemp;
  String myText3 = "Generacion: " + generation;
  String myText4 = "Dimension por poblacion: " + DIM;
  text(myText3, 50, 300);
  text(myText, 50, 200);
  text(myText2, 50, 250);
  if(aparecer3 || aparecer2){
  text(myText4, 50, 350);
  }
  
  stroke(255, 0, 0);
  line(550, 900, 0, 550, 0, 0);
  line(650, 900, 0, 650, 0, 0);
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
  
  skeleton =  kinect.getSkeletonDepthMap();
  //println(skeletonactive);
  //individual JOINTS
  noStroke();
  for (int i = 0; i < skeleton.length; i++) {
    
    if (skeleton[i].isTracked()) {
      skeletonactive = false;
      pobla = pobla + i;
       flechaTemp = flechaTemp + (0.1/2);
      if(activsis){
      KJoint[] joints2 = skeleton[i].getJoints();
      
      Body0Position(joints2, KinectPV2.JointType_FootLeft);
      Body0Position(joints2, KinectPV2.JointType_FootRight);
  

      Body0Position(joints2, KinectPV2.JointType_ThumbLeft);
      Body0Position(joints2, KinectPV2.JointType_ThumbRight);

      
      Body0Position(joints2, KinectPV2.JointType_HandTipRight);
      Body0Position(joints2, KinectPV2.JointType_HandTipLeft);
      Body0Position(joints2, KinectPV2.JointType_Head);
      
      // manos
      
      handriRight0(joints2[KinectPV2.JointType_HandRight]);
      handLeft0(joints2[KinectPV2.JointType_HandLeft]);
      }

  } 

  if(!skeleton[5].isTracked() && !skeleton[4].isTracked() && !skeleton[3].isTracked() && !skeleton[2].isTracked() && !skeleton[1].isTracked() && !skeleton[0].isTracked()) {
   skeletonactive = true;
   activsis = true;
  }
  
  // buscar mejor forma de hacer esto
  if(skeleton[0].isTracked() && skeleton[1].isTracked() || skeleton[0].isTracked() && skeleton[2].isTracked() || skeleton[0].isTracked() && skeleton[3].isTracked() || skeleton[0].isTracked() && skeleton[4].isTracked() || skeleton[0].isTracked() && skeleton[5].isTracked() || skeleton[1].isTracked() && skeleton[2].isTracked() || skeleton[1].isTracked() && skeleton[3].isTracked() || skeleton[1].isTracked() && skeleton[4].isTracked() || skeleton[1].isTracked() && skeleton[5].isTracked() || skeleton[2].isTracked() && skeleton[3].isTracked() || skeleton[2].isTracked() && skeleton[4].isTracked() || skeleton[2].isTracked() && skeleton[5].isTracked() ||
  skeleton[3].isTracked() && skeleton[4].isTracked() || skeleton[3].isTracked() && skeleton[5].isTracked() || skeleton[4].isTracked() && skeleton[5].isTracked()) {
  skeletonactive = true;
  activsis = false;
  }
  }
  
 // pushMatrix();
  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);

  FloatBuffer pointCloudBuffer = kinect.getPointCloudDepthPos();

  PJOGL pgl = (PJOGL)beginPGL();
  GL2 gl2 = pgl.gl.getGL2();

  gl2.glEnable( GL2.GL_BLEND );
  gl2.glEnable(GL2.GL_POINT_SMOOTH);      

  gl2.glEnableClientState(GL2.GL_VERTEX_ARRAY);
  gl2.glVertexPointer(3, GL2.GL_FLOAT, 0, pointCloudBuffer);
// width/65, height/55, zval-98
  gl2.glTranslatef(enx+50, eny, zval-98+84);
  gl2.glScalef(scaleVal, -1*scaleVal, scaleVal);
  gl2.glRotatef(aaa, 0.0f, 1.0f, 0.0f);

  gl2.glDrawArrays(GL2.GL_POINTS, 0, kinect.WIDTHDepth * kinect.HEIGHTDepth);
  gl2.glDisableClientState(GL2.GL_VERTEX_ARRAY);
  gl2.glDisable(GL2.GL_BLEND);
  endPGL();
 // popMatrix();
  //println(aparecer2);
if(selecTime){
  
   if(timer3){
    savedTime3 = millis();
    timer3 = false;
    }
    
    int passedTime3 = millis() - savedTime3;
    if (passedTime3 > totalTime3) {

      check++;
      savedTime3 = millis();
    }
    if(check % 2 == 0){
      aparecer3 = true; 
      aparecer = false;
    }else {
       aparecer = true;   
       aparecer3 = false;
    }
  }
      
    
  if(!skeletonactive && aparecer3 || !skeletonactive && aparecer2 || !skeletonactive && aparecer){
    selecTime = false;
  }
  
if(skeletonactive){
     
    selecTime = true;
    
    if(timer2){
    savedTime2 = millis();
    timer2 = false;
    }
    
    int passedTime2 = millis() - savedTime2;

    if (passedTime2 > totalTime2) {
//      updateColors();
      
      rIntens =(int)random(255);
      gIntens =(int)random(255);
      bIntens =(int)random(255);
      rFreq = (int)random(20);
      gFreq = (int)random(20);
      bFreq = (int)random(20); 
      flechaTemp = flechaTemp + 50;
      generation = generation +1;
      savedTime2 = millis(); // Save the current time to restart the timer!    
      if(aparecer3){
      DIM = (int)random(10, 35);
      atick=0;
      i=random(100);
      volume2=new VolumetricSpaceArray(SCALE,DIM,DIM,DIM); 
      surface2=new HashIsoSurface(volume2);
      brush2=new RoundBrush(volume2,10);
      ptc=new ArrayList();
      for(int i=0;i<pAmount;i++) {
        ptc.add(new Particle());
      }
      }
   }
      //runReaction = true;
   }  
   
  /**********************
  **      arduino      **
  **********************/
  
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  println(val);
  
}

void keyPressed() {
//  if(key=='a') {//move panels, change colors
//    aparecer=false;
//    aparecer2=false;
//  }
//  if(key=='b') {//move panels, change colors
//    aparecer=true;
//    aparecer2=true;
//  }
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
