class Scissors extends BulletObject {

  Scissors() {
  }

  Scissors(float startX, float startY, float velX, float velY, float theta, int player,color colour) {
    super(startX, startY, velX, velY, theta, player,colour);
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
    strokeWeight(2);
    stroke(200);
    fill(colour);
    if (vel.y>0||(player==1&&vel.y==0)) {
      arc(pos.x, pos.y, radius*2, radius*2, -QUARTER_PI, PI+QUARTER_PI, PIE);
    } else {
      arc(pos.x, pos.y, radius*2, radius*2,PI -QUARTER_PI, 2*PI+QUARTER_PI, PIE);
    }
  }
}

