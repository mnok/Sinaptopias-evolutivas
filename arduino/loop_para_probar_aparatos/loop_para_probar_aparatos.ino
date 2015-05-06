/*
A simple script to demonstrate the getting of
raw data from a Sharp IR Sensor.
*/

// Define the analog pin used to connect the
// sharp sensor
int relay = 13;
int relay2 = 12;
// A variable to store the values from sensor.
// This is initially zero.
int val;
// A variable to store the calculated cm value
// the setup routine runs once when you press
// reset:
void setup()
{
  pinMode(relay, OUTPUT);
  pinMode(relay2, OUTPUT); // Set pin as OUTPUT 
  // Set the pinmode to output
  // Initialise the serial stream
  Serial.begin(9600);
}
void loop()
{
  digitalWrite(relay, LOW);
  digitalWrite(relay2, LOW);
  delay(1000);
  digitalWrite(relay, HIGH);
  digitalWrite(relay2, HIGH);
  delay(1000);
  // read the value of the sharp sensor on A3
  // wait a little to make reading easier
  
}

