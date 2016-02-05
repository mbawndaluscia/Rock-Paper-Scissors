abstract class GameObject{
  PVector pos;
  int player;
  abstract void update();
  abstract void render();
  abstract void freeze();
}
