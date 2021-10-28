class HealthPowerUp extends Items{
  
  HealthPowerUp (PVector pos, PVector dim){
    super(pos,dim);
  }
  
  //Health powerup image
  void drawItem(int x, int y, PImage img){
    img=health;
    image(health,x,y);
  }
  
}
