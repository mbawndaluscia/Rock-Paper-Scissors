abstract class BulletObject extends GameObject {
  color colour;
  PVector vel;
  float theta;
  float speed;
  float radius=15;
  boolean moving=true;
  float borderL=100;
  float borderR=width-100;
  float borderT=10;
  float borderB=height-10;
  BulletObject() {
  }

  BulletObject(float startX, float startY, float velX, float velY, float _theta, int player) {
    this.pos=new PVector(startX, startY);
    vel=new PVector(velX, velY);
    theta=_theta;
    if(player==1){
       colour=color(255,0,0); 
      }else{
       colour=color(0,0,255); 
      }
   
  }

  void update() {
   
      pos.sub(vel);

    
      if ((pos.x > borderR-radius) || (pos.x < borderL+radius)) {
        vel.x = vel.x * -1;
      }
      if ((pos.y > borderB-radius) || (pos.y < borderT+radius)) {
        vel.y = vel.y * -1;
      }


      stroke(0);
      
      ellipse(pos.x, pos.y, 30, 30);
    
  }
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(colour);
    fill(colour);

    rotate(theta);
    popMatrix();
  }   

  void freeze() {
    vel.x=0;
    vel.y=0;
  }
}

