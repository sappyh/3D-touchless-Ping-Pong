import processing.opengl.*;

import processing.serial.*;

Serial serial;
int serialPort = 0;   // << Set this to be the serial port of your Arduino - ie if you have 3 ports : COM1, COM2, COM3 
                      // and your Arduino is on COM2 you should set this to '1' - since the array is 0 based
              
int sen = 3; // sensors
int div = 3; // board sub divisions
ttbat tt_bat1;
ttbat tt_bat2;
PImage tt_table;
float scale1=1.0;
float scale2=0.65;
float r=20.80;
ball ball1;
boolean hit=true;
int hits=0;
boolean cal=false;

int x,y;
int speedX=1,speedY=1;
int posX=190; int posY=248;
int h=height/2;

float[] xyz = new float[sen];

float[] max={0.00,0.0,0.0};

float[] min={10000.0,10000.0,10000.0};

  
  
  
  
float[] diff=new float[3];
void setup()
{
  size(400,400,OPENGL);
  tt_bat1=new ttbat(12,248,89,139,310,139,392,248);
  tt_bat2=new ttbat(105,117,122,94,277,94,298,119);
  ball1=new ball();
  
  println(Serial.list());
  serial = new Serial(this, Serial.list()[serialPort], 115200);
  
  tt_table=loadImage("tt_table.jpg");
  smooth();
  frameRate(25);
}

void draw()
{  updateSerial();
   println(xyz[0],xyz[1]);
  lights();
  background(tt_table);
  String t="hits:"+hits;
  textSize(12);
  text(t,0,width/2);
  noFill();
  if(x==1)
     scale1-=0.1;
    else if(x==2)
     scale1+=0.1;
  
  
  tt_bat1.display(xyz[0],xyz[1],scale1);
  if(ball1.posY>=50 || ball1.posY<30)
  tt_bat2.display(ball1.posX,35,scale2);
  else 
  tt_bat2.display(ball1.posX,(ball1.posY),scale2);
  
  if(cal)
  {
  
  if(tt_bat1.intersect(ball1.posX,ball1.posY,ball1.r) && ball1.posZ>0.6){
  if(hit==true)  {
  if(ball1.posY>100)
  ball1.settings(random(75,85),tt_bat1.powerX,tt_bat1.powerY+tt_bat1.powerZ,(tt_bat1.powerY+tt_bat1.powerZ)*0.003,0);
  else
  ball1.settings(random(65,75),tt_bat1.powerX,tt_bat1.powerY+tt_bat1.powerZ,(tt_bat1.powerY+tt_bat1.powerZ)*0.003+0.15,0);
  hits++;}
  hit=false; 
 }
 
 if(tt_bat2.intersect(ball1.posX,ball1.posY,ball1.r) && ball1.flag==2)
 {
   if(hit==false)
   ball1.settings(random(25,30),random(-0.1,0.1),random(1.5,3.0),-0.003,1);
   hit=true; 
 }
 
 if(hit==true&&ball1.posY<25)
 {
   String s="game over";
   textSize(48);
   text(s,100,150);
   noLoop();
 }
 ball1.display();
 hit=ball1.outofbounds(hit);
 
 
  
  x=0;
  }
}

void mouseReleased(){
  cal=true;
}
 
/*void keyPressed(){
if(key == CODED) {
   if(keyCode == UP) {
     x=1;
   }else if(keyCode == DOWN){
      x=2;
   }else x=0;
}}

void mousePressed(){
  loop();
}*/

void updateSerial() {
  
  
  String cur = serial.readStringUntil('\n');
  if(cur != null) {
    //println(cur);
    String[] parts = split(cur, " ");
    if(parts.length == sen  ) {
       for(int i = 0; i < sen; i++)
        xyz[i] = float(parts[i]);
       //println(xyz[0],xyz[1],xyz[2]);
       
       if(mousePressed && mouseButton == LEFT){
        for(int i = 0; i < sen; i++)
         {
           if(xyz[i] < min[i])
           min[i] = xyz[i];
           if(xyz[i] > max[i])
           max[i] = xyz[i];
         }   }
        
      for(int i=0;i<sen;i++){
        diff[i]=max[i]-min[i];  
        xyz[i]=(xyz[i]-min[i])*400/diff[i];
       }
    }
  }
}
