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

class Ball{
  //GLOBALL VARIABLES
  //float x = 0;
  //float y = 0;
 // float z = 0;
 // float speedX = random(-2,2);
 // float speedY = random(-2,2);
  //float speedZ = random(-2,2);

  Vec3D loc = new Vec3D (0,0,0);
  Vec3D speed = new Vec3D (random(-9,9),random(-9,9),random(-0.003,0.003));
  Vec3D acc = new Vec3D ();
  int radio;
  
  //CONSTRUCTOR
  Ball(Vec3D _loc, int m){
  loc = _loc;  
  radio = m;
  }
  
  //FUNCTIONS
  void run(){
  display();
  move();
  bounce();
  lineBetween();
  flock();
  }
  void flock(){
  separate(4);
  cohesion(0.001);
  aling(0.09);
  }
  
  void aling(float magnitude){
  Vec3D steer = new Vec3D();
  int count = 0;
    
    for(int i = 0; i < ballCollection. size(); i++) {
    Ball other = (Ball) (ballCollection. get(i));
    
    float distance = loc. distanceTo(other. loc);    
    if (distance > 0 && distance < 40){
    
     steer. addSelf(other.speed);
    count++; 
    }
    }
    if(count > 0){
     steer.scaleSelf(1.0/count);
    }
    
    steer.scaleSelf(magnitude);
    acc.addSelf(steer);
    
  }  
  void cohesion(float magnitude){
  Vec3D sum = new Vec3D();
    int count = 0;
    
    for(int i = 0; i < ballCollection. size(); i++) {
    Ball other = (Ball) (ballCollection. get(i));
    
    float distance = loc. distanceTo(other. loc);    
    if (distance > 0 && distance < 95){
      sum. addSelf(other.loc);
      count++;
    }
    }
    if (count > 0){
    sum.scaleSelf(1.0/count);
    }
    Vec3D steer = sum.sub(loc);
    
    steer.scaleSelf(magnitude);
    acc.addSelf(steer);
    
    color col  = getIndexColor(radio);
//      fill(col);
      stroke(col);
      
    if (count >= 5 && radio <= 30){
    radio++;
    }
    if (count <=1 && radio >= 10){
    radio--;
    }
    
    if (count >= 2 && radio == 30){
      Vec3D origin = new Vec3D (random(width),random(height),random(z));
      Ball myBall = new Ball (origin, crecer);
      ballCollection. add(myBall); 
    }
    
    if (count == 0 && radio == 10 || count >= 8){
      if(ballCollection.size()>1){
      ballCollection.remove(0);
    }
    }
  }
  
  void separate(float magnitude){
    
    Vec3D steer = new Vec3D();
    int count = 0; 
    
   for(int i = 0; i < ballCollection. size(); i++) {
    Ball other = (Ball) (ballCollection. get(i));
     
    float distance = loc. distanceTo(other. loc);    
    if (distance > 0 && distance < 80){
     
      Vec3D diff = loc. sub(other.loc);
      diff. normalizeTo(1.0/distance);
      
      steer. addSelf(diff);
      count ++;  
   }  
   }
  
   if(count < 0){
     steer. scaleSelf (1.0/count);
   }
   steer.scaleSelf(magnitude);
   acc.addSelf(steer);
   
  }  
   
  void move() {
    speed. addSelf(acc);
    speed. limit(2);
   loc.addSelf(speed);
   acc. clear();
  }

  void bounce(){
    if(loc.x > width){
      speed.x = speed.x * -1;
    }
    if(loc.x < 0){
      speed.x = speed.x * -1;
    }
    if(loc.y > height){
      speed.y = speed.y * -1;
    }
    if(loc.y < 0){
      speed.y = speed.y * -1;
    }
    if(loc.z > z){
      speed.z = speed.z * random(0.999,-1.991);
    }
    if(loc.z < 0){
      speed.z = speed.z * random(0.999,-1.991);
    }
  }
void lineBetween(){
  int count = 0;
    //ballCollection
  for(int i = 0; i < ballCollection. size(); i++) {
    Ball other = (Ball) (ballCollection. get(i));
    float distance = loc. distanceTo(other. loc);
    if (distance > 0 && distance < 170){
      stroke(random(105),random(155),random(155));
      strokeWeight(2);
      count++;
      line(loc.x,loc.y,loc.z,other.loc.x,other.loc.y,other.loc.z);
      hm.put(i, count);
//      println(count);
//      println(i);
      }
  }
  }  
 
 color getIndexColor(int index) {
  color col = color(255);
  if (index >= 10)
    col = color(random(150), 255, random(32));
  if (index <= 25)
    col = color(random(210), 0, 255);

  return col;
}
  
  void display(){
   
pushMatrix();
translate(loc.x,loc.y,loc.z);
noFill();
strokeWeight(0.32);
//stroke(105,155,155);
sphere(radio);
popMatrix();

  }
  
}

