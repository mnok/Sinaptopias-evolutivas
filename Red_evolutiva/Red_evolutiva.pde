/* 
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

import java.util.Map;
import toxi.geom.*;
import peasy.*;
PeasyCam jCam;

//DECLAIRE
float x,y,z;
int crecer = 10;
int canti = 120;
ArrayList ballCollection;
HashMap<Integer,Integer> hm = new HashMap<Integer,Integer>();

void setup() {
size(1000,700,P3D);
smooth();
jCam = new PeasyCam (this, 100);
x = width/1.5;
  y = height/1.5;
  z = 0;

//INITIALIZE

 ballCollection = new ArrayList();
 
for(int i=0; i < canti; i++){  
 Vec3D origin = new Vec3D (random(width),random(height),random(z));
 Ball myBall = new Ball (origin, crecer);
 ballCollection. add(myBall);
 }
 
}

void draw() {
  background(0);
  
   hint (DISABLE_DEPTH_TEST); 
  jCam.beginHUD(); 
  noLights();
  //stroke(300);
  
  

  fill(255, 0, 0);
  textSize(32);
  String myText = "Nodos: " + ballCollection. size();
  String myText2 = "Poblacion que se expande \npor hibridacion: " + (ballCollection. size()*3/2);
  String myText3 = "Hubs " + (ballCollection. size()/4);
  //String myText4 = "Hubs " + ;
  text(myText, 50, 100);
  text(myText2, 50, 150);
  text(myText3, 50, 250);
  //text(myText4, 50, 250);5


  jCam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
  
  
//  hm.put("Ava", 1);
//  hm.put("Cait", 35);
//  hm.put("Casey", 36);
  
    // Using an enhanced loop to interate over each entry
  for (Map.Entry me : hm.entrySet()) {
    print(me.getKey() + " is ");
    println(me.getValue());
  }
//  // We can also access values by their key
//  int val = hm.get("Casey");
//  println("Casey is " + val);

  
  
  //CALL FUNCTIONALITY
   for(int i=0; i < ballCollection. size(); i++){
 Ball mB = (Ball) ballCollection.get(i);
 mB. run();
}

  }

//void mouseClicked(){
//  if(mouseButton == LEFT){
//    if(ballCollection.size()>1){
//    ballCollection.remove(0);
//  }
//      }
//  
//  if(mouseButton == RIGHT){
//  Vec3D origin = new Vec3D (random(width),random(height),random(z));
// Ball myBall = new Ball (origin, crecer);
// ballCollection. add(myBall);
//}

//}
void mouseClicked(){
if(mouseButton == RIGHT){
  ballCollection = new ArrayList();
for(int i=0; i < canti; i++){  
 Vec3D origin = new Vec3D (random(width),random(height),random(z));
 Ball myBall = new Ball (origin, crecer);
 ballCollection. add(myBall);
 }
}
}
