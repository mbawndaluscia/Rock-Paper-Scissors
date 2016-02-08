ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
Cannon P1Cannon;
Cannon P2Cannon;
Post[] posts=new Post[6];

int p1Score, p2Score=0;
void setup() {

  size(900, 700);
  strokeWeight(4);

  P1Cannon=new Cannon(width/2, height-90, 'Q', 'E', 'W', PI, 1);
  P2Cannon=new Cannon(width/2, 90, 'L', 'J', 'K', PI, -1);
  gameObjects.add(P1Cannon);
  gameObjects.add(P2Cannon);



  posts[0]=new Post(width*5/8, height/2-120, 3.0f);
  posts[1]=new Post(width/4, height/2-60, -3.0f);
  posts[2]=new Post(width/2, height/2, 3.0f);
  posts[3]=new Post(width/2, height/2, -3.0f);
  posts[4]=new Post(width*3/4, height/2+60, -3.0f);
  posts[5]=new Post(width*3/8, height/2+120, 3.0f);

  for (int i=0; i<5; i++) {

    gameObjects.add(posts[i]);
  }
}
void draw() {
  background(150);
  drawGameScreen();

  for (int i = gameObjects.size () - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }

  checkCollisions();
  drawScore();
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void checkCollisions() {
  for (int i = gameObjects.size () - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);

    if (go instanceof BulletObject) {
      for (int j = gameObjects.size () - 1; j >= 0; j --)
      {
        GameObject go2 = gameObjects.get(j);

        if (go2 instanceof Post) {
          if (go.pos.dist(go2.pos) <=30.0f) {
            go.freeze();
          }
        }
        if (checkOutsideArcs(go.pos, go2.pos)) {
          if (go2 instanceof BulletObject&&go!=go2 ) {
            if (go.pos.dist(go2.pos) <=30.0f) {
              checkKill((BulletObject)go, (BulletObject)go2);

              // go.freeze();
              // go2.freeze();
            }
          }
        }
      }
    }
  }
}

void checkKill(BulletObject bo, BulletObject bo2) {
  boolean kill=false;
  //  if (bo.player==bo2.player) {
  //    if (bo.moving) {
  //     
  //      gameObjects.remove(bo2);
  //    }
  //  } else {

  if (bo instanceof Rock&&bo2 instanceof Paper) {
    gameObjects.remove(bo);
    kill=true;
    //      if (bo.player==1) {
    //        P1Cannon.locked=false;
    //      } else {
    //        P2Cannon.locked=false;
    //      }
  } else if (bo instanceof Paper&&bo2 instanceof Scissors) {
    gameObjects.remove(bo);
    kill=true;
    //      if (bo.player==1) {
    //        P1Cannon.locked=false;
    //      } else {
    //        P2Cannon.locked=false;
    //      }
  } else if (bo instanceof Scissors&&bo2 instanceof Rock) {
    gameObjects.remove(bo);
    kill=true;
    //      if (bo.player==1) {
    //        P1Cannon.locked=false;
    //      } else {
    //        P2Cannon.locked=false;
    //      }
    // }
  } else if (bo instanceof Star &&bo2 instanceof Star) {
    gameObjects.remove(bo);
     gameObjects.remove(bo2);
    kill=true;
  }else if (bo instanceof Star ) {
     gameObjects.remove(bo2);
    kill=true;
  }
  if (bo.player!=bo2.player&&kill) {
    updateScore(bo.player);
  }
}

void updateScore(int player) {
  if (player==1) {
    p1Score++;
  } else {
    p2Score++;
  }
}

void drawScore() {
  textSize(28);
  stroke(0);
  fill(0);
  text(p1Score, 10, 100);
  text(p2Score, 10, height-100);
}

boolean checkOutsideArcs(PVector p1, PVector p2) {
  if (p1.dist(P1Cannon.pos)<80||p1.dist(P2Cannon.pos)<80
    ||p2.dist(P1Cannon.pos)<80||p2.dist(P2Cannon.pos)<80) {
    return false;
  }
  return true;
}

void drawGameScreen() {
  stroke(255);
  fill(0);
  rectMode(CORNER);
  rect(100, 10, width-200, height-20);
  arc(width/2, height-10, 300, 300, -PI, 0);
  arc(width/2, 10, 300, 300, 0, PI);
}

