class Post extends GameObject{
  float radius=15;
  
  Post(){}
  
  Post(float posX,float posY){
    this.pos=new PVector(posX,posY);
    
  }
  
  void update(){
    stroke(187);
    fill(90);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  void render(){
    
  }
  
  void freeze(){
    
  }
  
}
