/*
 Copyright (C) 2014  Thomas Sanchez Lengeling.
 KinectPV2, Kinect one library for processing
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import KinectPV2.KJoint;
import KinectPV2.*;

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
float righthand = 0;
boolean savedata = true;
int corpid = 10;

void setup() {
  size(1024, 768, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeleton(true );
  kinect.enableSkeletonDepthMap(true);
  kinect.enableBodyTrackImg(true );

  kinect.init();

  // skeleton = new Skeleton[6];
}

void draw() {
  background(0);

  image(kinect.getBodyTrackImage(), 0, 0, 200, 200);
  skeleton =  kinect.getSkeletonDepthMap();

  //individual JOINTS
  for (int i = 0; i < skeleton.length; i++) {
    
    if (skeleton[i].isTracked()) {
      KJoint[] joints = skeleton[i].getJoints();
      
      
      drawBody(joints);
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      if(i == 0){
      KJoint[] joints2 = skeleton[0].getJoints();
      
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
  fill(255, 0, 0);
  text(frameRate, 50, 50);
}

void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm    
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);
  
  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);
  

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
   
  
}

void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  noStroke();
  fill(255);
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  noStroke();
  fill(255);
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  stroke(255);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

void drawHandState(KJoint joint) {
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 60, 60);
  popMatrix();
}

void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0, 120);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0, 120);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255, 120); 
    break;
  case KinectPV2.HandState_NotTracked:
    fill(100, 100, 100, 120);
    break;
  }
}

  /**********************
  **      cuerpo 0     **
  **********************/

void Body0Position(KJoint[] joints2, int jointType) {
  
  righthand = joints2[KinectPV2.JointType_HandTipRight].getX();
  
  if(righthand <= 400)
  {
    
  }
 println(joints2[KinectPV2.JointType_HandTipLeft].getX()); /// aqui salen los valores falta ver como dividir para saber que mano es
}

void handriRight0(KJoint joint2) {
  handStateright0(joint2.getState());
}

void handStateright0(int handStateright0) {
  switch(handStateright0) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    background(255);
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft0(KJoint joint2) {
  handStateLeft0(joint2.getState());
}

void handStateLeft0(int handStateLeft0) {
  switch(handStateLeft0) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

  /**********************
  **      cuerpo 1     **
  **********************/

void Body1Position(KJoint[] joints3, int jointType) {}

void handriRight1(KJoint joint3) {
  handStateright0(joint3.getState());
}

void handStateright1(int handStateright1) {
  switch(handStateright1) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft1(KJoint joint3) {
  handStateLeft1(joint3.getState());
}

void handStateLeft1(int handStateLeft1) {
  switch(handStateLeft1) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

  /**********************
  **      cuerpo 2     **
  **********************/

void Body2Position(KJoint[] joints4, int jointType) {}

void handriRight2(KJoint joint4) {
  handStateright2(joint4.getState());
}

void handStateright2(int handStateright2) {
  switch(handStateright2) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft2(KJoint joint4) {
  handStateLeft2(joint4.getState());
}

void handStateLeft2(int handStateLeft2) {
  switch(handStateLeft2) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

  /**********************
  **      cuerpo 3     **
  **********************/

void Body3Position(KJoint[] joints5, int jointType) {}

void handriRight3(KJoint joint5) {
  handStateright3(joint5.getState());
}

void handStateright3(int handStateright3) {
  switch(handStateright3) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft3(KJoint joint5) {
  handStateLeft3(joint5.getState());
}

void handStateLeft3(int handStateLeft3) {
  switch(handStateLeft3) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

  /**********************
  **      cuerpo 4     **
  **********************/

void Body4Position(KJoint[] joints6, int jointType) {}

void handriRight4(KJoint joint6) {
  handStateright4(joint6.getState());
}

void handStateright4(int handStateright4) {
  switch(handStateright4) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft4(KJoint joint6) {
  handStateLeft4(joint6.getState());
}

void handStateLeft4(int handStateLeft4) {
  switch(handStateLeft4) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

  /**********************
  **      cuerpo 5     **
  **********************/

void Body5Position(KJoint[] joints7, int jointType) {}

void handriRight5(KJoint joint7) {
  handStateright5(joint7.getState());
}

void handStateright5(int handStateright5) {
  switch(handStateright5) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft5(KJoint joint7) {
  handStateLeft5(joint7.getState());
}

void handStateLeft5(int handStateLeft5) {
  switch(handStateLeft5) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}
