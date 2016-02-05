class Scissors extends BulletObject {

  Scissors() {
  }

  Scissors(float startX, float startY, float velX, float velY, float theta, int player) {
    super(startX, startY, velX, velY, theta, player);
  }

  void update() {

    pos.sub(vel);
    

    if ((pos.x > borderR-radius) || (pos.x < borderL+radius)) {
      vel.x = vel.x * -1;
    }
    if ((pos.y > borderB-radius) || (pos.y < borderT+radius)) {
      vel.y = vel.y * -1;
    }
  }

  void render()
  {
    strokeWeight(4);
    stroke(187);
    fill(colour);

    arc(pos.x, pos.y, radius*2, radius*2, -QUARTER_PI, PI+QUARTER_PI, PIE);
  }
}

