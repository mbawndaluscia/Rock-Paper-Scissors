class Post extends GameObject{
  float radius=15;
  float vel;
  Post(){}
  
  Post(float posX,float posY,float _vel){
    this.pos=new PVector(posX,posY);
    vel=_vel;
  }
  
  void update(){
   pos.x+=vel;
    if ((pos.x > borderR-radius) || (pos.x < borderL+radius)) {
      vel =vel * -1;
    }
  }
  
  void render(){
    stroke(187);
    fill(115);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  void freeze(){
    
  }
  
}
