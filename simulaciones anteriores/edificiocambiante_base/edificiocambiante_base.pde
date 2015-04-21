/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/53493*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//  SPECULATIVE APPS 001: 'saturation' by echoechonoisenoise
//  architecture uses sketches to communicate and discuss ideas. what happens, when they become operative and anyone can modify them?

//  echoechonoisenoise added: fuzzy control, volumeutils mesh, colors and floor slabs :) using Shane Nelson's http://www.openprocessing.org/visuals/?visualID=49742

//  3d Belousov-Zhabotinsky reaction _ Tommaso Casucci
//  http://www.openprocessing.org/visuals/?visualID=38850

//  expansion of Alasdair Turner code
//  http://www.openprocessing.org/visuals/?visualID=1263

import peasy.*;
import toxi.volume.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*; 
import controlP5.*;

// agrego kinect

import java.nio.FloatBuffer;
import KinectPV2.KJoint;
import KinectPV2.*;
import javax.media.opengl.GL2;


PeasyCam cam;

ToxiclibsSupport gfx;

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
float scaleVal = 22;

//Distance Threashold distancia de captura 
float maxD = 10.0f; //meters
float minD = 0.3f;

// reconocimiento del cuerpo 


float rotX = PI;


// timer

/*int savedTime;
int totalTime = 1000;
boolean movehand = false;
boolean movehand2 = false;*/
boolean skeletonactive = true;

float xx = 0.7;
float yy = 0.45;
ControlP5 cp5;

void setup () {
  size(1200, 900, P3D);
  cam = new PeasyCam(this, 250);
  cam.rotateX(0.7);
  cam.rotateY(0.45);
  cam.rotateZ(-0.17);
  cp5 = new ControlP5(this);
 
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
  text(frameRate, 50, 50);
  stroke(255, 0, 0);
  line(550, 900, 0, 550, 0, 0);
  line(650, 900, 0, 650, 0, 0);
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
  
  skeleton =  kinect.getSkeletonDepthMap();

  //individual JOINTS
  for (int i = 0; i < skeleton.length; i++) {
    
    if (skeleton[i].isTracked()) {
     
     if(i == 0){
      KJoint[] joints2 = skeleton[0].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 0 activado", 50, 150);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
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
     if(i == 1){
      KJoint[] joints3 = skeleton[1].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 1 activado", 50, 200);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
      Body1Position(joints3, KinectPV2.JointType_FootLeft);
      Body1Position(joints3, KinectPV2.JointType_FootRight);
  

      Body1Position(joints3, KinectPV2.JointType_ThumbLeft);
      Body1Position(joints3, KinectPV2.JointType_ThumbRight);

      
      Body1Position(joints3, KinectPV2.JointType_HandTipRight);
      Body1Position(joints3, KinectPV2.JointType_HandTipLeft);
      Body1Position(joints3, KinectPV2.JointType_Head);
      
       // manos
      
      handriRight1(joints3[KinectPV2.JointType_HandRight]);
      handLeft1(joints3[KinectPV2.JointType_HandLeft]);
      }

     if(i == 2){
      KJoint[] joints4 = skeleton[2].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 2 activado", 50, 250);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
      Body2Position(joints4, KinectPV2.JointType_FootLeft);
      Body2Position(joints4, KinectPV2.JointType_FootRight);
  

      Body2Position(joints4, KinectPV2.JointType_ThumbLeft);
      Body2Position(joints4, KinectPV2.JointType_ThumbRight);

      
      Body2Position(joints4, KinectPV2.JointType_HandTipRight);
      Body2Position(joints4, KinectPV2.JointType_HandTipLeft);
      Body2Position(joints4, KinectPV2.JointType_Head);
      
       // manos
      
      handriRight2(joints4[KinectPV2.JointType_HandRight]);
      handLeft2(joints4[KinectPV2.JointType_HandLeft]);
      }
      
      if(i == 3){
      KJoint[] joints5 = skeleton[3].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 3 activado", 50, 300);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
      Body3Position(joints5, KinectPV2.JointType_FootLeft);
      Body3Position(joints5, KinectPV2.JointType_FootRight);
  

      Body3Position(joints5, KinectPV2.JointType_ThumbLeft);
      Body3Position(joints5, KinectPV2.JointType_ThumbRight);

      
      Body3Position(joints5, KinectPV2.JointType_HandTipRight);
      Body3Position(joints5, KinectPV2.JointType_HandTipLeft);
      Body3Position(joints5, KinectPV2.JointType_Head);
      
       // manos
      
      handriRight3(joints5[KinectPV2.JointType_HandRight]);
      handLeft3(joints5[KinectPV2.JointType_HandLeft]);
      }
      
      if(i == 4){
      KJoint[] joints6 = skeleton[4].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 4 activado", 50, 350);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
      Body4Position(joints6, KinectPV2.JointType_FootLeft);
      Body4Position(joints6, KinectPV2.JointType_FootRight);
  

      Body4Position(joints6, KinectPV2.JointType_ThumbLeft);
      Body4Position(joints6, KinectPV2.JointType_ThumbRight);

      
      Body4Position(joints6, KinectPV2.JointType_HandTipRight);
      Body4Position(joints6, KinectPV2.JointType_HandTipLeft);
      Body4Position(joints6, KinectPV2.JointType_Head);
      
       // manos
      
      handriRight4(joints6[KinectPV2.JointType_HandRight]);
      handLeft4(joints6[KinectPV2.JointType_HandLeft]);
      }
      
      if(i == 5){
      KJoint[] joints7 = skeleton[5].getJoints();
      
      hint (DISABLE_DEPTH_TEST); 
      cam.beginHUD(); 
      noLights(); 
  
      fill(255, 0, 0);
      text("cuerpo 5 activado", 50, 400);

      cam.endHUD(); 
      hint(ENABLE_DEPTH_TEST);
      
      Body5Position(joints7, KinectPV2.JointType_FootLeft);
      Body5Position(joints7, KinectPV2.JointType_FootRight);
  

      Body5Position(joints7, KinectPV2.JointType_ThumbLeft);
      Body5Position(joints7, KinectPV2.JointType_ThumbRight);

      
      Body5Position(joints7, KinectPV2.JointType_HandTipRight);
      Body5Position(joints7, KinectPV2.JointType_HandTipLeft);
      Body5Position(joints7, KinectPV2.JointType_Head);
      
       // manos
      
      handriRight5(joints7[KinectPV2.JointType_HandRight]);
      handLeft5(joints7[KinectPV2.JointType_HandLeft]);
      }
      
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
  gl2.glTranslatef(enx, eny, zval-98);
  gl2.glScalef(scaleVal, -1*scaleVal, scaleVal);
  gl2.glRotatef(aaa, 0.0f, 1.0f, 0.0f);

  gl2.glDrawArrays(GL2.GL_POINTS, 0, kinect.WIDTHDepth * kinect.HEIGHTDepth);
  gl2.glDisableClientState(GL2.GL_VERTEX_ARRAY);
  gl2.glDisable(GL2.GL_BLEND);
  endPGL();
 // popMatrix();
  
}

/*void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    stroke(0, 255, 0);
    movehand2 = true;
    movehand = true;
    break;
  case KinectPV2.HandState_Lasso:
    stroke(255, 0, 0);
    int passedTime = millis() - savedTime;;
  // Has five seconds passed?
  if(movehand){
  
  if (passedTime > totalTime) {
    savedTime = millis(); // Save the current time to restart the timer!
    movehand = false;
   
  }
  if(movehand2){
  savedTime = millis();
  movehand2 = false;
  }
  }
   println(passedTime);
    break;
  /*case KinectPV2.HandState_Lasso:
    stroke(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    stroke(100, 100, 100);
    break;
  }
}*/
 

