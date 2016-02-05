ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
Cannon P1Cannon;
Cannon P2Cannon;
Post[] posts=new Post[7];
void setup() {

  size(900, 700);
  strokeWeight(4);

  P1Cannon=new Cannon(width/2, height-50, 'Q', 'E', 'W', PI, 1);
  P2Cannon=new Cannon(width/2, 50, 'L', 'J', 'K', PI, -1);
  gameObjects.add(P1Cannon);
  gameObjects.add(P2Cannon);

  for (int i=0; i<7; i++) {
    posts[i]=new Post();
    gameObjects.add(posts[i]);
  }
  posts[0].pos=new PVector(width*3/8, height/3);
  posts[1].pos=new PVector(width*5/8, height/3);
  posts[2].pos=new PVector(width/4, height/2);
  posts[3].pos=new PVector(width/2, height/2);
  posts[4].pos=new PVector(width*3/4, height/2);
  posts[5].pos=new PVector(width*3/8, height*2/3);
  posts[6].pos=new PVector(width*5/8, height*2/3);
}
void draw() {
  background(187);
  drawGameScreen();

  for (int i = gameObjects.size () - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }

  checkCollisions();
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
          if (go.pos.dist(go2.pos) <=35.0f) {
            go.freeze();
          }
        }
        if (checkOutsideArcs(go.pos, go2.pos)) {
          if (go2 instanceof BulletObject&&go!=go2 ) {
            if (go.pos.dist(go2.pos) <=35.0f) {
              checkKill((BulletObject)go, (BulletObject)go2);

              go.freeze();
              go2.freeze();
            }
          }
        }
      }
    }
  }
}

void checkKill(BulletObject bo, BulletObject bo2) {
  //if (bo.player!=bo2.player) {
    if (bo instanceof Rock&&bo2 instanceof Paper) {
      gameObjects.remove(bo);

      if (bo.player==1) {
        P1Cannon.locked=false;
      } else {
        P2Cannon.locked=false;
      }
    } else if (bo instanceof Paper&&bo2 instanceof Scissors) {
      gameObjects.remove(bo);

      if (bo.player==1) {
        P1Cannon.locked=false;
      } else {
        P2Cannon.locked=false;
      }
    } else if (bo instanceof Scissors&&bo2 instanceof Rock) {
      gameObjects.remove(bo);

      if (bo.player==1) {
        P1Cannon.locked=false;
      } else {
        P2Cannon.locked=false;
      }
    }
  }
//}
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
  arc(width/2, height-10, 200, 200, -2*PI, PI/2);
  arc(width/2, 10, 200, 200, -2*PI, PI/2);
}

