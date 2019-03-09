#include <SoftwareSerial.h>
#include <Wire.h>
#include <Servo.h>

// DEBUG
bool DEBUG = true;
// Bluetooth
#define KEY 12
#define RXD 10
#define TXD 11
#define MAX_BTCMDLEN 128 // the maximum received command length from an Android system (over the bluetooth)
SoftwareSerial BTSerial(RXD, TXD);
// Servo motor
#define Servo_1_Data 5
#define Servo_2_Data 6
Servo Servo_1, Servo_2;
int pos_1 = 0, pos_2 = 0;

void setup()
{
  // Bluetooth
  pinMode(KEY, OUTPUT);
  digitalWrite(KEY, LOW); // AT Mode -> Normal(?) Mode
  Serial.begin(9600);
  BTSerial.begin(38400);
  // Servo motor
  Servo_1.attach(Servo_1_Data,500,2400);
  Servo_2.attach(Servo_2_Data,500,2400);
  Servo_1.write(90);
  Servo_2.write(90);
  delay(3000); // Wait for servo motor moving
}

void loop()
{
  // Bluetooth
  char _cmd[MAX_BTCMDLEN];
  int len = 0;
  memset(_cmd,0,MAX_BTCMDLEN);
  for(int i = 0; i < MAX_BTCMDLEN; i++)
  {
    for(int _len = 0; _len < BTSerial.available(); _len++)
    {
      _cmd[(len++)%MAX_BTCMDLEN] = BTSerial.read();
    }
  }
  // Servo motor
  // Main Function ?
  if(len != 0)
  {
    String cmd = String(_cmd);
    if(DEBUG)
    {
      Serial.print("Command: ");Serial.print(cmd);
      Serial.print(", Pos: ");Serial.print(pos_1);
      Serial.print(", ");Serial.println(pos_2);
    }
    if(cmd == "1")    { pos_1 = 90;}
    if(cmd == "2")  { pos_1 = -90;}
    if(cmd == "4")  { pos_2 = 90;}
    if(cmd == "5") { pos_2 = -90;}
    if(cmd == "0" or cmd == "3")  { pos_1 = 0; pos_2 = 0;}
    Servo_1.write(90 + pos_1);
    Servo_2.write(90 + pos_2);
    delay(100);
    
  }

}
