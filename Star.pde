class Star extends BulletObject {
  int elapsed;
  Star() {
  }

  Star(float startX, float startY, float velX, float velY, float theta, int player, color colour) {
    super(startX, startY, velX, velY, theta, player, colour);
    elapsed=0;
  }

  void update() {
    elapsed++;
    if (elapsed>180) {
      gameObjects.remove(this);
      explosion(pos.x, pos.y);
    }
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

    stroke(colour);
    fill(24);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    fill(colour);
    strokeWeight(4);
    float points=5;
    float  step = TWO_PI / points;

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(-90*player)); // Point upwards  

    beginShape();
    int  n = 0;
    for (int i = 0; i < points; ++i) {
      vertex( cos( step * n) * radius/2, sin( step * n) * radius/2);
      n += 2;
    }
    endShape(CLOSE);
    popMatrix();
  }
}

