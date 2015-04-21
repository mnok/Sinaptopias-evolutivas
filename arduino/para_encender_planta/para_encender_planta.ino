 // Wiring/Arduino code:
 // Read data from the serial and turn ON or OFF a light depending on the value
 
 char val; // Data received from the serial port
 int ledPin = 8; // Set the pin to digital I/O 4
 int relay = 13;
 int soil=0;
 
 int savedTime = 0;
 int totalTime = 12000;
 boolean timer = true;
 
 void setup() {
 pinMode(ledPin, OUTPUT); // Set pin as OUTPUT 
 pinMode(relay, OUTPUT); 
 Serial.begin(9600); // Start serial communication at 9600 bps
 }
 
 void loop() {  
   
  
 if (Serial.available()) { // If data is available to read,
 val = Serial.read(); // read it and store it in val
 }
 

      
 if (soil <= 50){
    if(timer){
    savedTime = millis();
    timer = false;
    }
    
    int passedTime = millis() - savedTime;

    if (passedTime > totalTime) {
     
     
 //if (val == 'H') { // If H was received
 digitalWrite(ledPin, LOW); // turn the LED on
 digitalWrite(relay, HIGH); 
 delay(3000);
 savedTime = millis();
 }
 } else {
 digitalWrite(ledPin, HIGH); // Otherwise turn it OFF
 digitalWrite(relay, LOW);
 }
 
 
  int sensorValue = analogRead(A0);
  sensorValue = constrain(sensorValue, 0, 1023);
  // print out the value you read:
  //Serial.println(sensorValue);

  //map the value to a percentage
  soil = map(sensorValue, 250, 400, 0, 100);
  
  // print out the soil water percentage you calculated:
  Serial.print(soil);
  Serial.print(sensorValue);
  Serial.println("%");
  Serial.write(soil); 
 delay(100); // Wait 100 milliseconds for next reading
}

