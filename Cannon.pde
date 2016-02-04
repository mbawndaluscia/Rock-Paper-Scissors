class Cannon extends GameObject {
  color colour;
  char left;
  char right;
  char fire;
  float theta;
  PVector aim;
  int player;
  int elapsed=0;
  

  Cannon(float posX, float posY, char _left, char _right, char _fire, float _theta, int _player) {
    this.pos=new PVector(posX, posY);
    aim=new PVector(0, 0);
    left=_left;
    right=_right;
    fire=_fire;
    theta=_theta;
    player=_player;
  }


  void update() {
    elapsed++;
    aim.x = sin(theta);
    aim.y = - cos(theta);


    if (theta>PI*2.0f/3.0f) {
      if (keys[left])
      {
        theta -= 0.05f;
      }
    }
    if (theta<PI+PI/3.0f) {
      if (keys[right]) {
        theta += 0.05f;
      }
    }

    if (keys[fire]&&elapsed>20)
    {
      elapsed=0;
      PVector shootAim=aim;
      shootAim.mult(5.0f);
      shootAim.mult(player);
      
      Rock rock = new Rock(pos.x, pos.y, shootAim.x, shootAim.y, theta, player);
      gameObjects.add(rock);
    }
  }



  void render()
  {
    text(aim.x, 55, 55);
    text(aim.y, 55, 75);
    text(pos.x, 55, 95);
    text(pos.y, 55, 115);
    text(theta, 55, 135);
    pushMatrix(); 
    translate(pos.x, pos.y);


    rotate(theta);    
    stroke(colour);
    fill(0);

    rectMode(CENTER);
    rect( 0, 0, 30, 100);
    ellipse(0, -50*player, 50, 50);

    popMatrix();
  }

  void freeze() {
  }
}

