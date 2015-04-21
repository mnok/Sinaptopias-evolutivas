import toxi.geom.*;
import peasy.*;
PeasyCam jCam;

//DECLAIRE
float x,y,z;

ArrayList ballCollection;
ArrayList ballCollection2;
ArrayList ballCollectionson;

void setup() {
size(1000,700,P3D);
smooth();
jCam = new PeasyCam (this, 100);
x = width/1.5;
  y = height/1.5;
  z = 0;

//INITIALIZE

 ballCollection = new ArrayList();
 
for(int i=0; i < 60; i++){  
 Vec3D origin = new Vec3D (random(width),random(height),random(z));
 Ball myBall = new Ball (origin);
 ballCollection. add(myBall);
 }
 
  ballCollection2 = new ArrayList();
 
for(int i=0; i < 60; i++){  
 Vec3D origin = new Vec3D (random(width),random(height),random(z));
 Ball2 myBall2 = new Ball2 (origin);
 ballCollection2. add(myBall2);
 }
 
   ballCollectionson = new ArrayList();
 
for(int i=0; i < 60; i++){  
 Vec3D origin = new Vec3D (random(width),random(height),random(z));
 Ballson myBallson = new Ballson (origin);
 ballCollectionson. add(myBallson);
 }
 
}

void draw() {
  background(255);
  
  //CALL FUNCTIONALITY
   for(int i=0; i < ballCollection. size(); i++){
 Ball mB = (Ball) ballCollection.get(i);
 mB. run();
}

   for(int i=0; i < ballCollection2. size(); i++){
 Ball2 mB2 = (Ball2) ballCollection2.get(i);
 mB2. run();
}

   for(int i=0; i < ballCollectionson. size(); i++){
 Ballson mBson = (Ballson) ballCollectionson.get(i);
 mBson. run();
}

  }

