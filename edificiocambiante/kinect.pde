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
 
boolean active = false;
boolean movehand2 = false;
boolean desarm = false;
boolean fondo = false;
boolean desarm1 = false;
boolean fondo1 = false;
boolean add = false;

  /**********************
  **      cuerpo 0     **
  **********************/

void Body0Position(KJoint[] joints2, int jointType) {
 
float righthand = 0;
float lefthhand = 0;
float lefthhandz = 0;
float righthhandz = 0;
int savedTime = 0;
int totalTime = 1000;

int passedTime = millis() - savedTime;

  lefthhand = joints2[KinectPV2.JointType_HandTipLeft].getX();
  righthand = joints2[KinectPV2.JointType_HandTipRight].getX();
  righthhandz = joints2[KinectPV2.JointType_HandTipRight].getY();
  lefthhandz = joints2[KinectPV2.JointType_HandTipLeft].getY();

  
  
  if(lefthhand <= 300 && bcgColor <= 200 && fondo) /// es 254 porque 254 +1 = 255
  {
    bcgColor++;
  } 
  if (lefthhand >= 400 && bcgColor >= 1 && fondo) /// es 1 porque 1-1 es 0
  {
    bcgColor--;
  }
  
  if(lefthhandz >= 200 && floorDensity <= 11) 
  {
    floorDensity++;
  }
  
  if(lefthhandz <= 200 && floorDensity >= 4) 
  {
    floorDensity--;
  }
  
  if(lefthhandz <= 200 && DIM <=8 && add)
  {
    DIM++;
  }
  if(lefthhandz >= 200 && DIM >=35 && add)
  {
    DIM--;
  }
  
if(active){
  
  if (passedTime > totalTime) {
      if(righthand >= 300 && active) 
      {
        xx = xx+0.1;
      } 
      if (righthand <= 400 && active)
      {
        xx = xx-0.1;
      }  
      
      if(righthhandz >= 100 && active) 
      {
        yy = yy+0.1;
      }
      
      if(righthhandz <= 200 && active) 
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
    active = true;
    movehand2 = true;
    break;
  case KinectPV2.HandState_Closed:
  if(aparecer3){
      fcount=0;
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
    if(aparecer2){
      DIM2 = (int)random(15, 20);
      //colorlittle = (int)random(10,255);
      atick=0;
      i2=random(100);
      volume3=new VolumetricSpaceArray(SCALE2,DIM2,DIM2,DIM2); 
      surface3=new HashIsoSurface(volume3);
      brush3=new RoundBrush(volume3,10);
      ptc2=new ArrayList();
      for(int i=0;i<pAmount2;i++) {
        ptc2.add(new Particle());
      }
      }
    if(aparecer){
    active = false;    
    rIntens =(int)random(255);
    gIntens =(int)random(255);
    bIntens =(int)random(255);
    rFreq = (int)random(20);
    gFreq = (int)random(20);
    bFreq = (int)random(20); 
    updateColors();
    generation = generation +1;
    }
    break;
  case KinectPV2.HandState_Lasso:
  if ( opacidad <= 254 && aparecer || opacidad <= 254 && aparecer2 || opacidad <= 254 && aparecer3){
    opacidad = opacidad +50;
    updateColors();
  }
    break;
  case KinectPV2.HandState_NotTracked:
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
  if(aparecer){
    fondo = false;
    runReaction = false;
  }
    break;
  case KinectPV2.HandState_Closed:
  if(aparecer){
    fondo = true;
    runReaction = true;
  }
  if(aparecer2 || aparecer3){
    add = true;
  }
    break;
  case KinectPV2.HandState_Lasso:
    if ( opacidad >= 10 && aparecer){
    opacidad = opacidad -50;
    updateColors();
  }
    break;
  case KinectPV2.HandState_NotTracked:
  if(aparecer){
    fondo = false;
    runReaction = false;
  }
    break;
  }
}


