abstract class GameObject{
  PVector pos;
  
  abstract void update();
  abstract void render();
  abstract void freeze();
}
