#define KEY 10
#define RXD 11
#define TXD 12
#include <SoftwareSerial.h>
#include <Wire.h>
#include <Servo.h>

// Servo motor
#define Servo_1_Data 5
#define Servo_2_Data 6
Servo Servo_1, Servo_2;
int pos_1 = 0, pos_2 = 0;


SoftwareSerial BT(RXD, TXD);

void setup() {
  BT.begin(38400);
  Serial.begin(9600);
  
  //setting motor
  pinMode(KEY, OUTPUT);
  digitalWrite(KEY, LOW);
  
  //testing motor
  Servo_1.attach(Servo_1_Data,500,2400);
  Servo_2.attach(Servo_2_Data,500,2400);
  Servo_1.write(90);
  Servo_2.write(90);
  delay(3000);
}

void loop() {
  int cmd[3],ptr=0;
  int table[5][3]={
      {128,128,128}, //2
      {248,128,128}, //3
      {120,248,128}, //5
      {128,248,128}, //6
      {248,248,128}  //7
    };
  while(1){
    while(BT.available()>0){;
      cmd[ptr] = BT.read();
      ptr++;
    }
    if(ptr == 3){
      for(int i=0;i<5;i++){
        int flag = 1;
        for(int j=0;j<3;  .j++){
          if(table[i][j]!=cmd[j]){
            flag = 0;
            break;
          }
        }
        if(flag > 0){
          if(i == 0){ //set to 180
            Servo_1.write(180);
            Serial.println(2);
          }
          else if(i == 1){ //set to 0
            Servo_1.write(0);
            Serial.println(3);
          }
          else if(i == 2){ //set to 180
            Servo_2.write(180);
            Serial.println(5);
          }
          else if(i == 3){ //set to 0
            Servo_2.write(0);
            Serial.println(6);
          }
          else if(i == 4){ //set both to 90
            Servo_2.write(90);
            Servo_1.write(90);
            Serial.println(7);
          }
          else{
            Serial.println("ERROR");
          }
        }
      }
      ptr = 0;
    }
    
  }
}
