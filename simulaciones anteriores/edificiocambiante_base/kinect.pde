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
boolean active = false;
boolean movehand2 = false;
boolean desarm = false;
boolean fondo = false;
boolean desarm1 = false;
boolean fondo1 = false;
  /**********************
  **      cuerpo 0     **
  **********************/

void Body0Position(KJoint[] joints2, int jointType) {
  
 println(joints2[KinectPV2.JointType_HandTipLeft].getX()); /// aqui salen los valores falta ver como dividir para saber que mano es
}

void handriRight0(KJoint joint2) {
  handStateright0(joint2.getState());
    
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint2.getX(), joint2.getY(), joint2.getZ());
  translate(350, 0);
  fill(0, 0, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright0(int handStateright0) {
  switch(handStateright0) {
  case KinectPV2.HandState_Open:
    runReaction = true;
    break;
  case KinectPV2.HandState_Closed:
    runReaction = false;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
  runReaction = false;
    break;
  }
}

void handLeft0(KJoint joint2) {
  handStateLeft0(joint2.getState());
  
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint2.getX(), joint2.getY(), joint2.getZ());
  translate(350, 0);
  fill(0, 0, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
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

void Body1Position(KJoint[] joints3, int jointType) {
println(joints3[KinectPV2.JointType_HandTipLeft].getX()); /// aqui salen los valores falta ver como dividir para saber que mano es
}

void handriRight1(KJoint joint3) {
  handStateright0(joint3.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint3.getX(), joint3.getY(), joint3.getZ());
  translate(350, 0);
  fill(0, 255, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright1(int handStateright1) {
  switch(handStateright1) {
  case KinectPV2.HandState_Open:
  runReaction = true;
    break;
  case KinectPV2.HandState_Closed:
  runReaction = false;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
  runReaction = false;
    break;
  }
}

void handLeft1(KJoint joint3) {
  handStateLeft1(joint3.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint3.getX(), joint3.getY(), joint3.getZ());
  translate(350, 0);
  fill(0, 255, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
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

void Body2Position(KJoint[] joints4, int jointType) {
float righthand = 0;
float lefthhand = 0;

  lefthhand = joints4[KinectPV2.JointType_HandTipLeft].getX();
  righthand = joints4[KinectPV2.JointType_HandTipRight].getX();
  
  if(righthand >= 400 && desarm)
  {
    new LaplacianSmooth().filter(mesh, 1);
  }
  

  
  if(lefthhand <= 300 && bcgColor <= 254 && fondo) /// es 254 porque 254 +1 = 255
  {
    bcgColor = bcgColor+1;
  } 
  if (lefthhand >= 400 && bcgColor >= 1 && fondo) /// es 1 porque 1-1 es 0
  {
    bcgColor = bcgColor-1;
  }
}

void handriRight2(KJoint joint4) {
  handStateright2(joint4.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint4.getX(), joint4.getY(), joint4.getZ());
  translate(350, 0);
  fill(255, 0, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();

  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright2(int handStateright2) {
  switch(handStateright2) {
  case KinectPV2.HandState_Open:
    desarm = false;
    break;
  case KinectPV2.HandState_Closed:
    desarm = true;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    desarm = false;
    break;
  }
}

void handLeft2(KJoint joint4) {
  handStateLeft2(joint4.getState());
  
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint4.getX(), joint4.getY(), joint4.getZ());
  translate(350, 0);
  fill(255, 0, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();

  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateLeft2(int handStateLeft2) {
  switch(handStateLeft2) {
  case KinectPV2.HandState_Open:
    fondo = false;
    break;
  case KinectPV2.HandState_Closed:
    fondo = true;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    fondo = false;
    break;
  }
}

  /**********************
  **      cuerpo 3     **
  **********************/

void Body3Position(KJoint[] joints5, int jointType) {
float righthand = 0;
float lefthhand = 0;

  lefthhand = joints5[KinectPV2.JointType_HandTipLeft].getX();
  righthand = joints5[KinectPV2.JointType_HandTipRight].getX();
  
  if(righthand >= 400 && desarm)
  {
    new LaplacianSmooth().filter(mesh, 1);
  }
  
  if(lefthhand <= 300 && bcgColor <= 254 && fondo) /// es 254 porque 254 +1 = 255
  {
    bcgColor = bcgColor+1;
  } 
  if (lefthhand >= 400 && bcgColor >= 1 && fondo) /// es 1 porque 1-1 es 0
  {
    bcgColor = bcgColor-1;
  }
}

void handriRight3(KJoint joint5) {
  handStateright3(joint5.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint5.getX(), joint5.getY(), joint5.getZ());
  translate(350, 0);
  fill(255, 255, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright3(int handStateright3) {
  switch(handStateright3) {
  case KinectPV2.HandState_Open:
    desarm1 = false;
    break;
  case KinectPV2.HandState_Closed:
    desarm1 = true;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    desarm1 = false;
    break;
  }
}

void handLeft3(KJoint joint5) {
  handStateLeft3(joint5.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint5.getX(), joint5.getY(), joint5.getZ());
  translate(350, 0);
  fill(255, 255, 0);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateLeft3(int handStateLeft3) {
  switch(handStateLeft3) {
  case KinectPV2.HandState_Open:
    fondo1 = false;
    break;
  case KinectPV2.HandState_Closed:
    fondo1 = true;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    fondo1 = false;
    break;
  }
}

  /**********************
  **      cuerpo 4     **
  **********************/

void Body4Position(KJoint[] joints6, int jointType) {
//float lefthhandx = 0;
float lefthhandz = 0;
//lefthhandx = joints6[KinectPV2.JointType_HandTipLeft].getX();
lefthhandz = joints6[KinectPV2.JointType_HandTipRight].getY();

 /* if(lefthhandx >= 200 && slabTreshold <= 29) 
  {
    slabTreshold = slabTreshold+0.1;
  } 
  if (lefthhandx <= 500 && slabTreshold >= 0.1)
  {
    slabTreshold = slabTreshold-0.1;
  }  */
  
  if(lefthhandz >= 100 && floorDensity <= 11) 
  {
    floorDensity = floorDensity+1;
  }
  
  if(lefthhandz <= 200 && floorDensity >= 4) 
  {
    floorDensity = floorDensity-1;
  }
  
 // println(joints6[KinectPV2.JointType_HandTipRight].getY());
 //println(slabTreshold);
  
}

void handriRight4(KJoint joint6) {
  handStateright4(joint6.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint6.getX(), joint6.getY(), joint6.getZ());
  translate(350, 0);
  fill(255, 0, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright4(int handStateright4) {
  switch(handStateright4) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    rFreq = (int)random(20);
    gFreq = (int)random(20);
    bFreq = (int)random(20); 
    updateColors();
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft4(KJoint joint6) {
  handStateLeft4(joint6.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint6.getX(), joint6.getY(), joint6.getZ());
  translate(350, 0);
  fill(255, 0, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateLeft4(int handStateLeft4) {
  switch(handStateLeft4) {
  case KinectPV2.HandState_Open:
    break;
  case KinectPV2.HandState_Closed:
    rIntens =(int)random(255);
    gIntens =(int)random(255);
    bIntens =(int)random(255);
    updateColors();
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

void Body5Position(KJoint[] joints7, int jointType) {
float lefthhandx = 0;
float lefthhandz = 0;
int savedTime = 0;
int totalTime = 1000;


lefthhandx = joints7[KinectPV2.JointType_HandTipRight].getX();
lefthhandz = joints7[KinectPV2.JointType_HandTipRight].getY();
int passedTime = millis() - savedTime;;

if(active){
  
  if (passedTime > totalTime) {
      if(lefthhandx >= 300 && active) 
      {
        xx = xx+0.1;
      } 
      if (lefthhandx <= 400 && active)
      {
        xx = xx-0.1;
      }  
      
      if(lefthhandz >= 100 && active) 
      {
        yy = yy+0.1;
      }
      
      if(lefthhandz <= 200 && active) 
      {
        yy = yy-0.1;
      }
    savedTime = millis(); // Save the current time to restart the timer!
    active = false;
  }
  if(movehand2){
  savedTime = millis();
  movehand2 = false;
  }
  }
   println(passedTime);  

  
  //println(active);
}

void handriRight5(KJoint joint7) {
  handStateright5(joint7.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint7.getX(), joint7.getY(), joint7.getZ());
  translate(350, 0);
  fill(0, 255, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
}

void handStateright5(int handStateright5) {
  switch(handStateright5) {
  case KinectPV2.HandState_Open:
    active = true;
    movehand2 = true;
    break;
  case KinectPV2.HandState_Closed:
    active = false;
    break;
  case KinectPV2.HandState_Lasso:
    break;
  case KinectPV2.HandState_NotTracked:
    break;
  }
}

void handLeft5(KJoint joint7) {
  handStateLeft5(joint7.getState());
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  pushMatrix();
  translate(joint7.getX(), joint7.getY(), joint7.getZ());
  translate(350, 0);
  fill(0, 255, 255);
  ellipse(0, 0, 30, 30);
  popMatrix();
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
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
