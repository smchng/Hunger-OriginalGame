//Class for the boss to shoot projectiles
//Simply draws the bullet and checks its walls
//Moving the bullet is already coded in parent class and rest of the code is in Boss

class Projectile extends MovingObject{
  
  boolean isAlive;
  
  Projectile(PVector pos, PVector vel, PVector dim) {
    super(pos,vel,dim);
    isAlive=true;
  }
  
  void update(ArrayList list){
    if(isAlive){
      super.move();
      checkWalls();
    }
    else list.remove(this);
  }
  
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    stroke(0);
    strokeWeight(3);
    ellipse(0,0,30,40);
    popMatrix();
  }
  
  void checkWalls(){
    if (pos.x > width||pos.x < 0||pos.y > 0||pos.y > height){
      isAlive=false;
    }
  }
}
