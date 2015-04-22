int numFrames = 3;  // The number of frames in the animation
int currentFrame = 0;
int[] cambio = new int[3];

boolean timer3 = true;

int savedTime3 = 0;
int totalTime3 = 2000;
    
void setup() {
  size(640, 360);
  frameRate(24);
  
  cambio[0]  = 4; 
  cambio[1]  = 5;
  cambio[2]  = 6; 
  
} 
 
void draw() { 
  background(0);
  
  int offset = 0;
  println(currentFrame);
  
  if(timer3){ // para guardar el timer sin ponerlo en el setup
    savedTime3 = millis();
    timer3 = false;
    }
    
    int passedTime3 = millis() - savedTime3;
    if (passedTime3 > totalTime3) {
      currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
      savedTime3 = millis();
    }

}
