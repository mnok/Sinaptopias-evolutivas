class Ball2{
  //GLOBALL VARIABLES
  //float x = 0;
  //float y = 0;
 // float z = 0;
 // float speedX = random(-2,2);
 // float speedY = random(-2,2);
  //float speedZ = random(-2,2);

  Vec3D loc = new Vec3D (0,0,0);
  Vec3D speed = new Vec3D (random(-8,8),random(-8,8),random(-0.001,0.001));
  Vec3D acc = new Vec3D ();
  
  //CONSTRUCTOR
  Ball2(Vec3D _loc){
  loc = _loc;  
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
    
    for(int i = 0; i < ballCollection2. size(); i++) {
    Ball2 other = (Ball2) (ballCollection2. get(i));
    
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
    
    for(int i = 0; i < ballCollection2. size(); i++) {
    Ball2 other = (Ball2) (ballCollection2. get(i));
    
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
  }
  
  void separate(float magnitude){
    
    Vec3D steer = new Vec3D();
    int count = 0; 
    
   for(int i = 0; i < ballCollection2. size(); i++) {
    Ball2 other = (Ball2) (ballCollection2. get(i));
    
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
    //ballCollection2
  for(int i = 0; i < ballCollection2. size(); i++) {
    Ball2 other = (Ball2) (ballCollection2. get(i));
    float distance = loc. distanceTo(other. loc);
    
    if (distance > 0 && distance < 170){
      stroke(random(105),random(155),random(155));
      strokeWeight(2);
      line(loc.x,loc.y,loc.z,other.loc.x,other.loc.y,other.loc.z);
      }
  }
  }
  void display(){ 
pushMatrix();
translate(loc.x,loc.y,loc.z);
noFill();
strokeWeight(0.32);
stroke(random(255),random(255),random(255));
sphere(random(8,10));
popMatrix();

  }
  
}
