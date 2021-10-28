//Parent class for the enemies
//Contains wall collisions for boss level and math to check collisions

class MovingObject{
  
    PVector pos, vel, dim;
    int healthBuffer=100;
    
    MovingObject(PVector pos, PVector vel, PVector dim){
      this.pos = pos;
      this.vel=vel;
      this.dim=dim;
    }
    
    void update(){
      move();
    }
    
    void move(){
      pos.add(vel);
    }
    
    //Any of the enemies, if they hit an obstacle, they bounce back
    void stuck(Walls w){
    if(w.pos.x>pos.x)pos.x=pos.x-15; vel.x*=-1;
    if(w.pos.y>pos.y)pos.y=pos.y-15; vel.y*=-1;
    if(w.pos.x<pos.x)pos.x=pos.x+15; vel.x*=-1;
    if(w.pos.y<pos.y)pos.y=pos.y+15; vel.y*=-1;
  }
  
  //Only wall collision for the boss level sicne all enemies are in it
  void checkWallsBoss(){
    if (pos.x<50) vel.x *= -1;
    if (pos.x>1000) vel.x *= -1;
    if (pos.y<100) vel.y *= -1;
    if (pos.y>750) vel.y *= -1;
  }
  
  //Checks if the enemy hit the player and calls the health decrease if so
  void hitCharacter(Player p){
    if(abs(pos.x-p.pos.x)<dim.x/2+p.dim.x/2 && abs(pos.y-p.pos.y)<dim.y/2+p.dim.y/2){
      healthBuffer--; //Another buffer so the players health does not rapidly decrease
      decreaseHealthPlayer();
    }
  }
  
  void decreaseHealthPlayer(){
    if (healthBuffer< 0){
      chop.play(0);
      playerHealth --;
      healthBuffer = 100;
    }
  }
  
  //Health bar that is drawn underneath the enemies
  //Parameters are for, placing the bar, the health of enemy and scaling the bar size
  void healthBar(int size, int health, int placeX, int placeY, int maxHealth){
    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(CORNER);
    strokeWeight(3);
    fill(#FF6262);
    stroke(#FF3E3E);
    float newHealth = (float) health/maxHealth;
    rect(placeX,placeY, size*newHealth, 8);  
    popMatrix();
  }
}
