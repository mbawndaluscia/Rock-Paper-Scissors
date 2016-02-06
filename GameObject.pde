abstract class GameObject{
  float borderL=100;
  float borderR=width-100;
  float borderT=10;
  float borderB=height-10;
  PVector pos;
  int player;
  abstract void update();
  abstract void render();
  abstract void freeze();
}
