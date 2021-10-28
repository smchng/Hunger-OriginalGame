class Chest extends Items{
  
  Chest(PVector pos, PVector dim){
    super(pos,dim);
  }
  
  //draws chest that the players goal is to reach
  void drawItem(int x, int y, PImage img){
     img=chest;
     image(chest, x,y);
  }
  
}
