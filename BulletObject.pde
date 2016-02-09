abstract class BulletObject extends GameObject {
  color colour;
  PVector vel;
  float theta;

  float radius=15;
  boolean moving=true;

  int player;
  BulletObject() {
  }

  BulletObject(float startX, float startY, float velX, float velY, float _theta, int _player, color _colour) {
    this.pos=new PVector(startX, startY);
    vel=new PVector(velX, velY);
    theta=_theta;
    player=_player;
    colour=_colour;
  }



  void freeze() {
    vel.x=0;
    vel.y=0;
    if (moving) {
      moving=false;
      if (player==1) {
        P1Cannon.locked=false;
      } else {
        P2Cannon.locked=false;
      }
    }
  }
}

