class Particle {
  Vec3D pos;//using toxi's Vec3D instead of PVector-VolumetricBrush requirements
  float speed;
  int spread=95; 
  Particle() {
    pos=new Vec3D(random(-spread,spread),random(-spread,spread),random(-spread,spread));
    speed=100;
  }
  void behave() {   
    pos.x+=(noise(i,pos.x*sc,pos.y*sc)-.5)*speed;
    pos.y+=(noise(i+1,pos.x*sc,pos.z*sc)-.5)*speed;
    pos.z+=(noise(i+2,pos.x*sc,pos.y*sc)-.5)*speed;
  }
  void display() {
    brush2.drawAtAbsolutePos(pos,brushDensity);//drawing particle paths with volumetric brush
    brush3.drawAtAbsolutePos(pos,brushDensity2);//drawing particle paths with volumetric brush
  }
}
