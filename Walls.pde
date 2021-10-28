//This code draws obstacles in each levels
//There are blocks placed in certain areas that the character cannot walk over
//It checks if the obstacles collide with enemies or the player
//What happens if they collide is implemented in their own methods
//Level 2 and 3 obstacles are not coloured because the art on its own already shows the places the character cannot walk over
//So it is combined into 1 regular method

class Walls{
  
  PVector dim,pos;
  
  Walls(PVector pos, PVector dim){
    this.pos = pos;
    this.dim = dim;
  }
  
  //2 separate wall checks for enemy and player
  boolean check(Player c) {
      if (abs(c.pos.x - pos.x) < c.dim.x / 2 + dim.x / 2 && 
          abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
           return true;
      }
      return false;
    }
  boolean check(BasicEnemy e) {
    if (abs(e.pos.x - pos.x) < e.dim.x / 2 + dim.x / 2 && 
        abs(e.pos.y - pos.y) < e.dim.y / 2 + dim.y / 2){
         return true;
    }
    return false;
  }
  
  //Draws the shaped for level 1 
  void drawMeLevel1(){
    pushMatrix();
    rectMode(CENTER);
    fill(#fbe1a7);
    stroke(#fdd888);
    strokeWeight(5);
    rect(pos.x,pos.y,dim.x,dim.y);
    popMatrix();
  }
  
  //Rest of the levels and just blocks
  void drawMeRegular(){
    pushMatrix();
    rectMode(CENTER);
    noFill();
    noStroke();
    rect(pos.x,pos.y,dim.x,dim.y);
    popMatrix();
  }
}
