abstract class BulletObject extends GameObject {
  color colour;
  PVector vel;
  float theta;

  float radius=15;
  
  int strokeW;

  int player;
  BulletObject() {
  }

  BulletObject(float startX, float startY, float velX, float velY, float _theta, int _player, color _colour,int _strokeW) {
    this.pos=new PVector(startX, startY);
    vel=new PVector(velX, velY);
    theta=_theta;
    player=_player;
    colour=_colour;
    strokeW=_strokeW;
  }



  void freeze() {
    vel.x=0;
    vel.y=0;
  }
}

