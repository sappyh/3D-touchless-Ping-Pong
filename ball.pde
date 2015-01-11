class ball{
  
  float speedX=0.0,speedY=0.0,speedZ=0.0;
  float posX=200,posY=200,posZ=1.0;
  float max,min;
  int flag=0;
  float initial_r=15;
  float r=10;
 
  
  void settings(float mn,float sx,float sy,float z,int region)
  {
        speedX=sx;
        speedY=sy;
        speedZ=z;
        min=mn;
        if(region==0)
        max=random(90,110);
        else
        max=random(201,248);
        flag=0;
      }

  void display()
  {   

      posX+=speedX;
      
      if(posY>min && flag==0)
      {
       posY-=speedY;
       if(speedZ>0)
       posZ-=speedZ;
      }
  
      if(posY<=min && flag==0)
       flag=1;
    
      if (flag==1 && posY<max )
      {
        posZ-=speedZ;
        posY+=speedY;
      }
      
      if(flag==1 && posY>max)
       flag=2;
      
      if(flag==2)
      {
        posY-=speedY;
       posZ-=speedZ;
      }
     
     if(posZ>1.0)
     {
       posZ=1.0;
     }
     if(posZ<0.3)
     {
       posZ=0.3;
     }
     
      
        if(posY>30 && posY<300){
        pushMatrix();
        translate(posX,posY);
        scale(posZ);
        noStroke();
        fill(255,69,0);
        sphere(15);
        popMatrix();}
        r=initial_r*posZ;
      
  }
  
    boolean outofbounds(boolean x){
     if(posX<(188-0.706*posY-5) || posX>(205.5+0.75*posY+5))
     {
       if(posY>=max && posY<=119){
       String s="out of court";
       fill(0);
       textSize(48);
       text(s,100,200);
       posX=200;
       posY=200;
       posZ=1.0;
       flag=0;
       speedX=0.0; speedY=0.0; speedZ=0.0;
       x=true;
       noLoop();}
     }
     return x;
     }
}
    
    
   
