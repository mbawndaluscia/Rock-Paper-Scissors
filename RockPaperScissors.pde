ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void setup() {

  size(600, 600);
 


  Cannon P1Cannon=new Cannon(width/2, height-50, 'Q', 'E', 'W', PI, 1);
  Cannon P2Cannon=new Cannon(width/2, 50, 'L', 'J', 'K', PI, -1);
  gameObjects.add(P1Cannon);
  gameObjects.add(P2Cannon);
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
        if (go!=go2&&go2 instanceof BulletObject) {
          if (go.pos.dist(go2.pos) <31.0f) {
            go.freeze();
            go2.freeze();
          }
        }
      }
    }
  }
}

void drawGameScreen() {
  stroke(0);
  fill(187);
  rectMode(CORNER);
  rect(100, 10, width-200, height-20);
}

