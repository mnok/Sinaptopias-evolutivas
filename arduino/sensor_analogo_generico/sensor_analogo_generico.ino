/*
A simple script to demonstrate the getting of
raw data from a Sharp IR Sensor.
*/

// Define the analog pin used to connect the
// sharp sensor
int sensorpin = 3;
// A variable to store the values from sensor.
// This is initially zero.
int val;
// A variable to store the calculated cm value
// the setup routine runs once when you press
// reset:
void setup()
{
  // Set the pinmode to output
  pinMode(sensorpin,OUTPUT);
  // Initialise the serial stream
  Serial.begin(9600);
}
void loop()
{
  // read the value of the sharp sensor on A3
  val = analogRead(sensorpin);
  // prints the value of the sensor to serial
  Serial.print(val);
  Serial.println();
  // wait a little to make reading easier
  delay(100);
}

