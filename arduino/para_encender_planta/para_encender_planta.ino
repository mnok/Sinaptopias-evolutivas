char val; // Data received from the serial port
int ledPin1 = 13; // Set the pin to digital I/O 4
int ledPin2 = 12;
int ledPin3 = 11;
int ledPin4 = 10;
int relay = 8;
int sensorproxi = 3;
int porPh=0;
int porProxi=0;
int sensorlight = 1;

int savedTime = 0;
int totalTime = 12000;
boolean timer = true;
 
void setup() {
 pinMode(relay, OUTPUT); // Set pin as OUTPUT 
 pinMode(ledPin1, OUTPUT);
 pinMode(ledPin2, OUTPUT);
 pinMode(ledPin3, OUTPUT);
 pinMode(ledPin4, OUTPUT);
 pinMode(sensorproxi, OUTPUT);
 pinMode(sensorlight, OUTPUT);
 Serial.begin(9600); // Start serial communication at 9600 bps
}
 
void loop() {   
  
 if (porPh <= 40){
    if(timer){
    savedTime = millis();
    timer = false;
    }
    
    int passedTime = millis() - savedTime;

    if (passedTime > totalTime) {
       digitalWrite(relay, LOW);
       digitalWrite(ledPin2, HIGH);
       digitalWrite(ledPin4, HIGH);
       digitalWrite(ledPin3, LOW);
       delay(3000);
       savedTime = millis();
    }
 } else {
   digitalWrite(relay, HIGH);
   digitalWrite(ledPin2, LOW);
   digitalWrite(ledPin4, LOW);
   digitalWrite(ledPin3, HIGH);
 }
 
  if(porProxi >=10){
    digitalWrite(ledPin1, HIGH); 
  }
  else {
    digitalWrite(ledPin1, LOW);
  }
  
 
  sensorlight = analogRead(A1);
  int phSensor = analogRead(A0);
  int proxiSensor = analogRead(A3);
  phSensor = constrain(phSensor, 0, 1023);
//  proxiSensor = constrain(proxiSensor, 0, 980);
  // print out the value you read:

  //map the value to a percentage
  porPh = map(phSensor, 250, 400, 0, 100);
  porProxi = map(proxiSensor, 10, 980, 0, 100); // sensor proximidad
  
  // print out the soil water percentage you calculated:
 // Serial.print(porProxi);
  Serial.print(sensorlight);
  Serial.println("%");
  Serial.write(porPh); 
  Serial.write(porProxi); 
  delay(100); // Wait 100 milliseconds for next reading
}


