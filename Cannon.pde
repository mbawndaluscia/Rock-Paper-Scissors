class Cannon extends GameObject {
  color colour;
  char left;
  char right;
  char fire;
  float speed;
  float theta;
  PVector aim;
  int player;
  int elapsed=0;
  boolean locked=false;
  BulletObject nextBullet;

  Cannon(float posX, float posY, char _left, char _right, char _fire, float _theta, int _player) {
    this.pos=new PVector(posX, posY);
    aim=new PVector(0, 0);
    left=_left;
    right=_right;
    fire=_fire;
    theta=_theta;
    player=_player;
    speed=6.0f;
    randomBullet();
  }


  void update() {
    elapsed++;
    aim.x = sin(theta);
    aim.y = - cos(theta);


    if (theta>PI*2/3) {
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
      if (!locked) {
        locked=true;


        elapsed=0;
        shootBullet();
        gameObjects.remove(nextBullet);
        randomBullet();
      }
    }
  }



  void render()
  {
    strokeWeight(4);
    if (player==1) {
      colour=color(255, 0, 0);
    } else {
      colour=color(0, 0, 255);
    }  
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

  void randomBullet() {

    int r=int(random(3));
    if (r==0) {
      nextBullet = new Rock(22, 22, 0, 0, theta, player);
     
    } else if (r==1) {
      nextBullet  = new Paper(pos.x, pos.y, 0, 0, theta, player);
     
    } else if (r==2) {
      nextBullet = new Scissors(pos.x, pos.y, 0, 0, theta, player);
     
    }
     gameObjects.add(nextBullet );
  }

  void shootBullet() {
    PVector shootAim=aim;
    shootAim.mult(speed);
    shootAim.mult(player);
    if (nextBullet instanceof Rock) {
      Rock rock = new Rock(pos.x, pos.y, shootAim.x, shootAim.y, theta, player);
      gameObjects.add(rock);
    } else if (nextBullet instanceof Paper) {
      Paper paper = new Paper(pos.x, pos.y, shootAim.x, shootAim.y, theta, player);
      gameObjects.add(paper);
    } else if (nextBullet instanceof Scissors) {
      Scissors scissors = new Scissors(pos.x, pos.y, shootAim.x, shootAim.y, theta, player);
      gameObjects.add(scissors);
    }
  }
  void freeze() {
  }
}

