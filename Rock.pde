class Rock extends BulletObject {

  Rock() {
  }

  Rock(float startX, float startY, float velX, float velY, float theta, int player) {
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


  void render() {
    strokeWeight(2);
    stroke(187);
    fill(colour);

    rectMode(CENTER);
    rect(pos.x, pos.y, radius*2, radius*2);

    line(pos.x-radius, pos.y-radius/2, pos.x+radius, pos.y-radius/2);
    line(pos.x-radius, pos.y, pos.x+radius, pos.y);
    line(pos.x-radius, pos.y+radius/2, pos.x+radius, pos.y+radius/2);
    line(pos.x, pos.y+radius, pos.x, pos.y+radius/2);
    line(pos.x, pos.y, pos.x, pos.y-radius/2);
    line(pos.x-radius/2, pos.y+radius/2, pos.x-radius/2, pos.y);
    line(pos.x-radius/2, pos.y-radius/2, pos.x-radius/2, pos.y-radius);
    line(pos.x+radius/2, pos.y+radius/2, pos.x+radius/2, pos.y);
    line(pos.x+radius/2, pos.y-radius/2, pos.x+radius/2, pos.y-radius);
  }
}

