class Paper extends BulletObject {

  Paper() {
  }

  Paper(float startX, float startY, float velX, float velY, float theta, int player,color colour) {
    super(startX, startY, velX, velY, theta, player,colour);
  }
  void update() {

    pos.sub(vel);
    theta+=0.1f;

    if ((pos.x > borderR-radius) || (pos.x < borderL+radius)) {
      vel.x = vel.x * -1;
    }
    if ((pos.y > borderB-radius) || (pos.y < borderT+radius)) {
      vel.y = vel.y * -1;
    }
  }

  void render() {
    strokeWeight(2);
    stroke(colour);
    fill(255);
    rectMode(CENTER);
    rect(pos.x, pos.y, radius*2, radius*2);

    line(pos.x-radius+4, pos.y-radius/2-1, pos.x+radius-4, pos.y-radius/2-1);
    line(pos.x-radius+4, pos.y, pos.x+radius-4, pos.y);
    line(pos.x-radius+4, pos.y+radius/2+1, pos.x+radius-4, pos.y+radius/2+1);
  }
}

