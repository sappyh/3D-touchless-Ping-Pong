
class ttbat{
  
  PImage tt_bat=loadImage("tt.png");
  int leftbtmx,lefttopx,righttopx,rightbtmx,leftbtmy,lefttopy,righttopy,rightbtmy;
  float xpos,ypos;
  float prev_xpos=200.0;float prev_ypos=200.0;float prev_scl=1.0;
  float scale;
  float initial_r=20.80;
  float r=20.80;
  float powerX=0.0;
  float powerY=0.0;
  float powerZ=0.0;
  
  //constructor
  ttbat(int left_btmx,int left_btmy,int left_topx,int left_topy,int right_topx,int right_topy,int right_btmx,int right_btmy)
  {
    leftbtmx=left_btmx;
    rightbtmx=right_btmx;
    lefttopx=left_topx;
    righttopx=right_topx;
    leftbtmy=left_btmy;
    rightbtmy=right_btmy;
    lefttopy=left_topy;
    righttopy=right_topy;
  }
 
  void display(float x,float y,float scl)
  {
    xpos=x;
    ypos=y;
    r=initial_r*scl;
    pushMatrix();
    translate(xpos,ypos);
    rotate(powerX+powerY*0.5);
    rotateY(powerX+powerY*0.2+powerZ);
    scale(scl);
    image(tt_bat,-r,-r,75,75);
    popMatrix();
    powerX=(xpos-prev_xpos)*0.01;
    powerY=abs((ypos-prev_ypos)*0.1);
    powerZ=scl-prev_scl;
    if(powerY<0.5)
     powerY=0.5;
    prev_xpos=xpos;
    prev_ypos=ypos;
    prev_scl=scl;
  }
    
  
  boolean intersect(float x,float y,float r1)
  {
    if((r+r1)<dist(xpos,ypos,x,y))
    return false;
    else return true;}
}
