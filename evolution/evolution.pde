//import ddf.minim.spi.*;
//import ddf.minim.signals.*;
import ddf.minim.*;
//import ddf.minim.analysis.*;
//import ddf.minim.ugens.*;
//import ddf.minim.effects.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import processing.dxf.*;
import processing.serial.*;

Minim minim;
AudioPlayer[] soundfx;

PeasyCam cam;

boolean show_web = true;
boolean record =false ;

static final int min_beasts = 50;
static final int max_beasts = 90;
int stagnation_point = 600 ; // 20 sec at 30 FPS
int num_beasts;
int last_num_beasts;
int population_age = 0;

ArrayList<Beast> beasts;
int num_bubbles;
ArrayList<Bubble> bubbles;
int luz = 0;

color filter_hue;

Serial myPort;      // The serial port
int[] serialInArray = new int[3]; // Where we'll put what we receive
int serialCount = 0;     // A count of how many bytes we receive
int var1, var2, var3;

void setup() {
  
  size(1280, 720, P3D);
  noTint();
  
  cam = new PeasyCam(this,10);
  cam.rotateX(PI*0.3);
  cam.rotateZ(PI*0.3);
  
  filter_hue = 250;
  
  beasts = new ArrayList<Beast>();
  bubbles = new ArrayList<Bubble>();
  
  
  
  
  // make an initial population
  num_beasts = (int)random(min_beasts, max_beasts);
  last_num_beasts = num_beasts;
  for ( int i=0; i<num_beasts; i++ ) {
    
    beasts.add(new Beast(random(width), random(height), random(0, 500), random(8, 75)));
    Beast beast = beasts.get(i);
    beast.getgoing();
    beast.set_genome();
  }
  
  // create some bubbles to float around
  num_bubbles = 1;
  for (int i=0; i<num_bubbles; i++ ) {
    
    bubbles.add(new Bubble());
 //   Bubble bubble = bubbles.get(i);
  }
  
  // setup the sound & loop background track
  minim = new Minim(this);
  soundfx = new AudioPlayer[1];
  soundfx[0] = minim.loadFile("bgtrk.mp3");
//  soundfx[0] = minim.loadFile("bgtrk.ogg"); //NB: Not supported in java - UNcomment for js version!
  // soundfx[0].setGain(-24);                     //NB: Not present in minim.js - comment OUT for js version
  soundfx[0].loop();

  colorMode(HSB, 360, 100, 100);
  noStroke();
  smooth(8);
  
  // arduino
  
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my FTDI adaptor, so I open Serial.list()[0].
 // On Windows machines, this generally opens COM1.
 // Open whatever port is the one you're using.
 String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 9600);
  
}

void draw() {
  if ( frameCount%20 == 0 ) {
    filter_hue = ++filter_hue%360;
  }
 // background(0);
  background(filter_hue, 100, 100, 60);
  noTint();
  //image(bgimg,0,0); // background(bgimg);
  
  
  hint (DISABLE_DEPTH_TEST); 
  cam.beginHUD(); 
  noLights();
  //stroke(300);

  fill(255, 0, 0);
  textSize(32);
  String myText = "Luz: " + luz;
  //String myText4 = "Hubs " + ;
  text(myText, 50, 100);
  
  cam.endHUD(); 
  hint(ENABLE_DEPTH_TEST);
  
  // draw some bubbles over the background
  for (int i=0; i<bubbles.size(); i++ ) {
    Bubble bubble = bubbles.get(i);
    bubble.move_bubble();
    bubble.draw_bubble();
    bubble.updater(mouseX,mouseY,i);
  }
  
//    pushMatrix();
//    translate(width/2, height/2, width/2);
////    fill(255,255,255,50);
//    noFill();
//    box(width);
//    endShape();
//    popMatrix();
    luz = var3;
  // color filter - changes slowly to add a bit of extra visual interest
//  fill(filter_hue, 100, 100, 60);
//  noStroke();
//  rect(0,0,width,height);

  
  // for each beast
  for (int i=0; i<beasts.size(); i++) {
    Beast beast = beasts.get(i);
    
    // move it
    beast.move();
    
    // look for a target/enemy and change direction if necessary
    beast.hunt(i);

    // display it
    beast.display();
    
    // eat or be eaten
    beast.encounter(i);
    
    // if you're mature, make little beasts
    beast.reproduce();
    
  }
  
  // If the population's too stagnant, we need some new blood
  num_beasts = beasts.size();
  if ( num_beasts == last_num_beasts ) {
    ++population_age;
    if ( population_age >= stagnation_point ) {
      // make some more
      int newbeasts = (int)random(min_beasts/2, max_beasts/2);
      for ( int i=0; i<newbeasts; i++ ) {
        beasts.add(new Beast(random(width), random(height), random(0, 500), random(8, 75)));
        Beast newbeast = beasts.get(last_num_beasts+i);
        newbeast.getgoing();
        newbeast.set_genome();
      }
      num_beasts = beasts.size(); last_num_beasts = num_beasts; population_age = 0;
    }
  } else {
    last_num_beasts = num_beasts;
    population_age = 0;
  }
  
    if (record == true) {
    beginRaw(DXF, "shapes/shape-####.dxf");
  }
  if (record == true) {
    endRaw();
    record = false; // Stop recording to the file
  }
  
}

void serialEvent(Serial myPort){
String myString = myPort.readStringUntil(124); //the ascii value of the "|" character
if(myString != null ){
  myString = trim(myString); //remove whitespace around our values
  int inputs[] = int(split(myString, ','));
  //now assign your values in processing
  if(inputs.length == 4){
    var1 = inputs[0];
    var2 = inputs[1];
    var3 = inputs[2];
  }
}
}

void keyPressed() {
  switch(key) {
    case 'w': show_web = !show_web; break;
  }
    if(key=='r') {//save to dxf
    record = true;
  }
}


/*
 * Class definition for the beast object
 */
static final int MIN_SPINES = 3;
static final int MAX_SPINES = 20;
 
class Beast {
  
  float x, y, z, size, original_size;    // Set in initialisation routine

  float direction, wander;     // These are randomised in getgoing routine
  float nuc_dx, nuc_dy, nuc_dz;
  color nucleus_color;
  PVector[] q_puntos;
  PVector[] q_ptss;

  float speed;                        // Initially random, but inherited from parent
  color bcolor;                       // visual indicators of speed, which can mutate,
                                      // and gives evolutionary advantage.
  boolean atract;                                   
  int fillIn;
  int followTime;


  
  Beast(float x_, float y_, float z_, float size_) {
    x = x_;
    y = y_;
    z = z_;
    size = size_;
    original_size = size_;
    q_puntos=new PVector[7];
    construct();
    
    atract = false;
    followTime = millis();

  }

  // lets get moving
  void getgoing() {
    direction = random(0, TWO_PI);
    wander = random(radians(-5), radians(5)); // rate of change of direction - degrees per frame
    nuc_dx = random(-size/6, size/6);
    nuc_dy = random(-size/6, size/6);
    nuc_dz = random(-size/6, size/6);
  }
  
  // initialise the inherited characteristics
  void set_genome() {
    speed = random(1, 4);
    float hue = random(176, 330);
    colorMode(HSB, 360, 100, 100);
    bcolor = color(hue, 100, 100, 90);
    nucleus_color = color(hue, 100, 40, 200);
  }
  
  // copy over inheritable characteristics
  void inherit(Beast oldbeast, Beast newbeast) {
    newbeast.speed = oldbeast.speed;
    newbeast.q_puntos = oldbeast.q_puntos;
    newbeast.bcolor = oldbeast.bcolor;
    newbeast.nucleus_color = oldbeast.nucleus_color;
  }

  // move according to current speed and direction - stay on the screen
  void move() {
    if (!atract){
    float dx = speed*cos(direction);
    float dy = speed*sin(direction);
    float dz = speed*cos(5);
    x += dx;
    y += dy;
    z += dz;
    direction -= wander;
    // wrap around the spherical topology if we hit the side
    if ( x < -size/2 ) x = width + size/2 ; if ( x > width + size/2 ) x = -size/2;
    if ( y < -size/2 ) y = width + size/2 ; if ( y > width + size/2 ) y = -size/2;
    if ( z < -size/2 ) z = width + size/2 ; if ( z > width + size/2 ) z = -size/2;
    }
  }
  
  // draw to screen
  void display() {
    fill(bcolor);
    stroke(nucleus_color);
    draw_beast(x, y, z, size, q_puntos);
  }
  
  // is there something nearby? Do we chase it or run away?
  void hunt(int thisbeast) {
    if (!atract){
    float range, range_of_detection;
    Beast me = beasts.get(thisbeast);
    
    // only interact if I'm on the screen - need a chance to get back in play otherwise
    if ( me.x > me.size/2 && me.x < width-me.size/2 && me.y > me.size/2 && me.y < width-me.size/2 && me.z > me.size/2 && me.z < width-me.size/2) {
      // check for nearby beasts
      for (int i=beasts.size()-1; i>=0; i--) {
        if (i != thisbeast ) {
          Beast otherbeast = beasts.get(i);
          range_of_detection = (me.size+otherbeast.size)*2 + random(0, me.size/2); // more random variation to combat stalemate situations
          range = dist(me.x, me.y, me.z, otherbeast.x, otherbeast.y, otherbeast.z);
          if ( range <= range_of_detection ) {
            if (show_web) { // visualise web of conflicting influences
              strokeWeight(0.4);
              stroke(69,29,85,200); // stroke(me.nucleus_color);
              line(me.x+me.nuc_dx, me.y+me.nuc_dy, me.z+me.nuc_dz, otherbeast.x+otherbeast.nuc_dx, otherbeast.y+otherbeast.nuc_dy, otherbeast.z+otherbeast.nuc_dz);
            }
            // chase it!
            me.direction = -acos( (otherbeast.x - me.x )/range );
            if ( otherbeast.y > me.y ) me.direction += PI;
            // unless it's bigger than me, then run away (with random variation to help avoid stalemates)!
            if ( me.size <= otherbeast.size ) me.direction = -me.direction + radians(random(-30, 30));
          }
        }
      }
    }
    }
  }
  
  // find something smaller than yourself? eat it!
  void encounter(int thisbeast) {
    if (!atract){
    Beast me = beasts.get(thisbeast);
    // check those other beasts
    for (int i=beasts.size()-1; i>=0; i--) {
      if (i != thisbeast ) {
        Beast otherbeast = beasts.get(i);
        if ( dist(me.x, me.y, me.z, otherbeast.x, otherbeast.y, otherbeast.z) < (me.size+otherbeast.size)/2 && me.size>otherbeast.size ) {
          // gain area, not just diameter!
          size = 2*sqrt( sq(me.size/2) + sq(otherbeast.size/2) );
          beasts.remove(otherbeast);
        }
      }
    }
    }
  }

  // make little beasts!
  void reproduce() {
    Beast oldbeast = this;
    if (oldbeast.size >= 1.2*oldbeast.original_size) {
      oldbeast.size=oldbeast.size*0.6;
      beasts.add(new Beast(x, y, z, oldbeast.size ));
      Beast newbeast = beasts.get(beasts.size()-1);
      oldbeast.getgoing();          // and send off in differerent directions
      newbeast.getgoing();
      inherit(oldbeast, newbeast);  // inherit characteristics
      oldbeast.mutate();            // either one could mutate
      newbeast.mutate();
    }
  }
  
  // beast could spontaneously mutate to get a bit faster or slower.
  // faster is an advantage - link to no. of spines and redness as visual indicators
  void mutate() {
    if ( random(0,2) < 1 ) {  // 1 in 3 chance of mutation
      float increment = random(-1, 1);
      int mut = int(random(1 , 7));
      speed += increment;
      if (increment > 0) {
        float bhue = hue(bcolor);
        if (bhue > 0) {
          bhue -= 10;
          bcolor = color(bhue, saturation(bcolor), brightness(bcolor), alpha(bcolor));
        }
        switch(mut)
        {
          case 1:
               q_puntos[0] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break; 
          case 2:
               q_puntos[1] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break;
          case 3:
               q_puntos[2] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break; 
          case 4:
               q_puntos[3] = new PVector(random(0, 75), random(0, 90), random(0, 75)); 
               break; 
          case 5:
               q_puntos[4] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break; 
          case 6:
               q_puntos[5] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break; 
          case 7:
               q_puntos[6] = new PVector(random(0, 75), random(0, 90), random(0, 75));
               break;
          default:
               break;
        }
      }
    }
  }
//  
  void construct() {
    
    q_puntos[0] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    q_puntos[1] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    q_puntos[2] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    q_puntos[3] = new PVector(random(0, 75), random(0, 90), random(0, 75)); 
    q_puntos[4] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    q_puntos[5] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    q_puntos[6] = new PVector(random(0, 75), random(0, 90), random(0, 75));
    
  }
//  
  // draw a beast
  void draw_beast(float x, float y, float z, float size, PVector[]q_puntos1) {
    
    // draw the cell body
    strokeWeight(size/30);
    
    pushMatrix();
    translate(x-50, y-50, z-50);
    fill(bcolor);
    scale(size/45);
    beginShape(TRIANGLE_STRIP);
    vertex(q_puntos1[0].x, q_puntos1[0].y, q_puntos1[0].z);
    vertex(q_puntos1[1].x, q_puntos1[1].y, q_puntos1[1].z);
    vertex(q_puntos1[2].x, q_puntos1[2].y, q_puntos1[2].z);
    vertex(q_puntos1[3].x, q_puntos1[3].y, q_puntos1[3].z);
    vertex(q_puntos1[4].x, q_puntos1[4].y, q_puntos1[4].z);
    vertex(q_puntos1[5].x, q_puntos1[5].y, q_puntos1[5].z);
    vertex(q_puntos1[6].x, q_puntos1[6].y, q_puntos1[6].z);
    endShape();
    popMatrix();    
  }
  
  // agrego el atractor
  
   void update(float followX, float followY, float followZ){     
     if(millis()-followTime<2000 && millis()-followTime>100){
        x = followX + random(10-250);
        y = followY + random(10-250);
        z = followZ + random(10-250);
        atract = true;
     } else {
       atract = false;
     }
     
//    for(int i = 0; i < bubbles.size(); i++) {
//      Bubble atractor = (Bubble) (bubbles.get(i));
//    float distance = me. dist(atractor. dist);
//    if (distance > 0 && distance < 170){
//      stroke(random(105),random(155),random(155));
//      strokeWeight(2);
//      line(loc.x,loc.y,loc.z,other.loc.x,other.loc.y,other.loc.z);
//      }
//    }
  }
 
}
/*
 * Class definition for the bubble object
 */

class Bubble {
 
  float x, y, z, size, speed, direction, wander;
  color bubble_col = color(184, 8, 95, 9);

  Bubble() {
     x = random(width);
     y = random(width);
     z = random(width);
     size = random( 100, 150 );
     speed = random(0.1, 0.2);
     direction = random( -PI/4, PI/4 );
     wander = 0.003; // random( 0.001, 0.008 );
  }
  
  void move_bubble() {
    x = x + speed*cos(direction);
    y = y + speed*sin(direction);
    z = z + speed*cos(5);
    direction += wander;
    if ( x < -size/2 ) x = width + size/2 ; if ( x > width + size/2 ) x = -size/2;
    if ( y < -size/2 ) y = width + size/2 ; if ( y > width + size/2 ) y = -size/2;
    if ( z < -size/2 ) z = width + size/2 ; if ( z > width + size/2 ) z = -size/2;
  }
  
  void updater(int attractorX, int attractorY, int thisatractor){
    x = x+var1;
    y = y+var2;
    z = z-var2;
    float range, range_of_detection;
    Bubble me = bubbles.get(thisatractor);
    
    for (int i=beasts.size()-1; i>=0; i--) {
      Beast otherbeast = beasts.get(i);
      range_of_detection = 500; // more random variation to combat stalemate situations
      range = dist(me.x, me.y, me.z, otherbeast.x, otherbeast.y, otherbeast.z);
      if ( range <= range_of_detection ) {
   
      otherbeast.update(x, y, z);
    }
   }
  }
  
  void draw_bubble() {
    noFill();
    stroke(bubble_col);
    for ( int i=0; i<4; i++ ) {
      pushMatrix();
     // strokeWeight(size/(i+1));
      fill(var3, 220,150);
      translate(x, y, z);
      sphere(size);
      popMatrix();
//      ellipse(x, y, size, size);      
    }
  }
    
}


