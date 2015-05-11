// This example code is in the public domain.
import processing.serial.*;

int bgcolor;   // Background color
int fgcolor;   // Fill color
Serial myPort;      // The serial port
int[] serialInArray = new int[3]; // Where we'll put what we receive
int serialCount = 0;     // A count of how many bytes we receive
int xpos, ypos, zpos;     // Starting position of the ball
int var1, var2, var3;
boolean firstContact = false;  // Whether we've heard from the
          // microcontroller
void setup() {
 size(256, 256); // Stage size
 noStroke();  // No border on the next thing drawn
 // Set the starting position of the ball (middle of the stage)
 xpos = width/2;
 ypos = height/2;
 // Print a list of the serial ports, for debugging purposes:
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my FTDI adaptor, so I open Serial.list()[0].
 // On Windows machines, this generally opens COM1.
 // Open whatever port is the one you're using.
 String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 9600);
}
void draw() {
 background(bgcolor);
 fill(255);
 // Draw the shape
// ellipse(xpos, ypos, 20, 20);
}
void serialEvent(Serial myPort){
String myString = myPort.readStringUntil(124); //the ascii value of the "|" character
if(myString != null ){
  myString = trim(myString); //remove whitespace around our values
  int inputs[] = int(split(myString, ','));
  //now assign your values in processing
  if(inputs.length == 3){
    var1 = inputs[0];
    var2 = inputs[1];
    var3 = inputs[2];
  }
  println(var2);
}

}
