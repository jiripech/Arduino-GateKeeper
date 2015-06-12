#include <Servo.h> 
 
Servo G1;
Servo G2;
 
int gate1pin = 9;
int gate2pin = 7;

int pos = 90;
int incomingByte = 0;

String crlf = "\n";

void setup() { 
  Serial.begin(9600);
  G1.attach(gate1pin);
  G2.attach(gate2pin);
  G1.write(120);
  delay(100);
  G2.write(50);
  delay(100);
  Serial.print("Ready");
  delay(100);
  G1.detach();
  G2.detach();
} 

void openGate(int gateNo) {
  if (gateNo == 1) {
    G1.attach(gate1pin);
    delay(10);
    for(pos = 120; pos <= 180; pos += 1) {
      G1.write(pos);
      delay(round(pos / 100) + 1);
    }
    delay(1000);
    for(pos = 180; pos >= 120; pos -= 1) {
      G1.write(pos);
      delay(round(pos / 100) + 1);
    }
    delay(50);
    G1.detach();
  }

  if (gateNo == 2) {
    G2.attach(gate2pin);
    delay(10);
    for(pos = 50; pos >= 0; pos -= 1) {
      G2.write(pos);
      delay(round((pos) / 100) + 1);
    }
    delay(1000);
    for(pos = 0; pos <= 50; pos += 1) {
      G2.write(pos);
      delay(round((pos) / 100) + 1);
    }
    delay(50);
    G2.detach();
  }
}
 
void loop() { 
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if ((incomingByte == 49) || (incomingByte == 1)) {
      Serial.print("Gate 1" + crlf);
      openGate(1);
    }
    if ((incomingByte == 50) || (incomingByte == 2)) {
      Serial.print("Gate 2" + crlf);
      openGate(2);
    }
  }
}
