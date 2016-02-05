class Paper extends BulletObject {

  Paper() {
  }

  Paper(float startX, float startY, float velX, float velY, float theta, int player) {
    super(startX, startY, velX, velY, theta, player);
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

    stroke(187);
    fill(colour);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}

