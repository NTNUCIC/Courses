#include <Wire.h>
#include <Servo.h>
#define DataPin 9
Servo MyServo;
void setup() {
	MyServo.attach(DataPin, 500, 2400);
	MyServo.write(90);
}
void loop() {
	MyServo.write(120);
	delay(1000);
	MyServo.write(60);
	delay(1000);
}
