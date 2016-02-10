//Import minim for sound effects
import ddf.minim.*;
Minim minim;
//Sound effects
AudioSnippet rockSound;
AudioSnippet paperSound;
AudioSnippet scissorsSound;
AudioSnippet starSound;

boolean started=false;
char start='1';
char instructions='2';
color P1Colour=color(148, 32, 211);
color P2Colour=color(50, 205, 50);
//Arraylist of game objects
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

//Cannons
Cannon P1Cannon;
Cannon P2Cannon;

//Array of stopper objects
Stopper[] stoppers=new Stopper[6];


//Score variables
int p1Score, p2Score=0;




void setup() {

  size(900, 700);
  strokeWeight(4);

  //Initialise game objects
  P1Cannon=new Cannon(width/2, height-90, 'Q', 'E', 'W', PI, 1, P1Colour );
  P2Cannon=new Cannon(width/2, 90, 'L', 'J', 'K', PI, -1, P2Colour);
  gameObjects.add(P1Cannon);
  gameObjects.add(P2Cannon);

  stoppers[0]=new Stopper(width*5/8, height/2-120, 3.0f);
  stoppers[1]=new Stopper(width/4, height/2-60, -3.0f);
  stoppers[2]=new Stopper(width/2, height/2, 3.0f);
  stoppers[3]=new Stopper(width/2, height/2, -3.0f);
  stoppers[4]=new Stopper(width*3/4, height/2+60, -3.0f);
  stoppers[5]=new Stopper(width*3/8, height/2+120, 3.0f);

  for (int i=0; i<6; i++) {
    gameObjects.add(stoppers[i]);
  }

  //Initialise sound effects
  Minim minim =new Minim(this);
  rockSound=minim.loadSnippet("rockSound.wav");
  paperSound=minim.loadSnippet("paperSound.wav");
  scissorsSound=minim.loadSnippet("scissorsSound.wav");
  starSound=minim.loadSnippet("starSound.mp3");
  rockSound.setGain(-30);//Too loud, reduce
  starSound.setGain(-10);
}
void draw() {

  if (!started) {
    openingScreen();
  } else {
    background(150);

    drawGameScreen();


    //update and render game objects
    for (int i = gameObjects.size () - 1; i >= 0; i --)
    {
      GameObject go = gameObjects.get(i);
      go.update();
      go.render();
    }
    //Check for collisions
    checkCollisions();

    //Draw updated score
    drawScore();
  }
}

//Check for key presses
boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
  if (keys[start]) {
    started=!started;
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}

//Collision check method
void checkCollisions() {

  //Loop through game objects
  for (int i = gameObjects.size () - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);

    //Check if it's a bullet
    if (go instanceof BulletObject) {

      //Loop again to check against other objects
      for (int j = gameObjects.size () - 1; j >= 0; j --)
      {
        GameObject go2 = gameObjects.get(j);

        //Check if 2nd object is a stopper
        if (go2 instanceof Stopper) {
          if ( go instanceof Star==false) {//Stars can pass through stoppers

            //Freeze bullet if it hits stopper
            if (go.pos.dist(go2.pos) <=30.0f) {
              go.freeze();
            }
          }
        }

        //No collisions inside arcs at each end
        if (checkOutsideArcs(go.pos, go2.pos)) {

          //Check we aren't checking self-collision
          if (go2 instanceof BulletObject&&go!=go2 ) {

            //Check for kills if collision occurs
            if (go.pos.dist(go2.pos) <=30.0f) {
              checkKill((BulletObject)go, (BulletObject)go2);
              checkKill((BulletObject)go2, (BulletObject)go);
            }
          }
        }
      }
    }
  }
}

//Check for kills method
void checkKill(BulletObject bo, BulletObject bo2) {
  boolean kill=false;

  if (bo instanceof Rock&&bo2 instanceof Paper) {
    paperSound.play(0);
    gameObjects.remove(bo);
    explosion(bo.pos.x, bo.pos.y);
    kill=true;
  } else if (bo instanceof Paper&&bo2 instanceof Scissors) {
    scissorsSound.play(0);
    gameObjects.remove(bo);
    explosion(bo.pos.x, bo.pos.y);
    kill=true;
  } else if (bo instanceof Scissors&&bo2 instanceof Rock) {
    rockSound.play(0);
    gameObjects.remove(bo);
    explosion(bo.pos.x, bo.pos.y);
    kill=true;
  } else if (bo instanceof Star &&bo2 instanceof Star) {
    starSound.play(0);
    gameObjects.remove(bo);
    gameObjects.remove(bo2);
    explosion(bo.pos.x, bo.pos.y);
    explosion(bo2.pos.x, bo2.pos.y);
  } else if (bo instanceof Star ) {
    starSound.play(0);
    gameObjects.remove(bo2);
    explosion(bo.pos.x, bo.pos.y);
  }

  //Update scores after kill
  if (bo.player!=bo2.player&&kill) {
    updateScore(bo.player);
  }
}


//Update scores
void updateScore(int player) {
  if (player==1) {
    p1Score++;
  } else if (player==-1) {
    p2Score++;
  }
}

//Draw the scores
void drawScore() {
  textSize(60);
  textAlign(LEFT);
  stroke(0);
  fill(0);
  text(p1Score, 10, 100);
  text(p2Score, 10, height-100);
}

//Check bullets are  outside of arcs
boolean checkOutsideArcs(PVector p1, PVector p2) {
  if (p1.dist(P1Cannon.pos)<80||p1.dist(P2Cannon.pos)<80
    ||p2.dist(P1Cannon.pos)<80||p2.dist(P2Cannon.pos)<80) {
    return false;
  }
  return true;
}

void explosion(float posX, float posY) {
  strokeWeight(1);
  stroke(255, 255, 0);
  fill(24);
  for (int i =48; i>=12; i-=4)
    ellipse(posX, posY, i, i);
}



//Draw opening menu
void openingScreen() {
  background(24);
  Rock rock=new Rock(width/2, height/8, 0, 0, 0, 0, P2Colour, 12);
  rock.radius=90;
  rock.render();
  Paper paper=new Paper(width/4, height/2, 0, 0, 0, 0, P2Colour, 12);
  paper.radius=90;
  paper.render();
  Scissors scissors=new Scissors(width*3/4, height/2, 0, 0, 0, 0, P2Colour, 12);
  scissors.radius=90;
  scissors.render();
  textAlign(CENTER, CENTER);
  textSize(96);
  fill(P1Colour);
  text("ROCK", width/2, height/8);
  text("PAPER", width/4, height/2);
  text("SCISSORS", width*3/4, height/2);
  textSize(48);
  text("1-START GAME", width/2, height*6/8);
  text("2-GAME RULES", width/2, height*7/8);
}

//Draw the game screen
void drawGameScreen() {
  strokeWeight(4);
  stroke(255);
  fill(24);
  rectMode(CORNER);
  rect(100, 10, width-200, height-20);
  arc(width/2, height-10, 300, 300, -PI, 0);
  arc(width/2, 10, 300, 300, 0, PI);
}

void displayInstructions() {
}


//Stop method for minim
void stop() {

  rockSound.close();
  paperSound.close();
  scissorsSound.close();
  minim.stop();

  super.stop();
}

