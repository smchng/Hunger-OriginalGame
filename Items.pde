//This is the class that contains the extra items the player will interact with
//The health powerup is in here as well and the chest
//It only draws the items and checks if it collided with the enemy

class Items{
  PVector pos, dim;
  
  Items(PVector pos, PVector dim){
    this.pos=pos;
    this.dim=dim;
  }
  
  //Checks if player touched items
  boolean check(Player c) {
    if (abs(c.pos.x - pos.x) < c.dim.x / 2 + dim.x / 2 && 
        abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      return true;
    }
    return false;
  }
  
  //method to draw the item
  void drawItem(int x, int y, PImage img){
     image(img, x,y);
  }
  
}
