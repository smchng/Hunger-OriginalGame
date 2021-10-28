//This is a parent class for enemies
//This draws a a bee which is the weakest and lowest enemy
//It has the methods to move the enemies, detect wall and obstacle collision 
//With player health decrease and collision 

class BasicEnemy extends MovingObject{
  
  int basicHealth;
  PImage bee;
  float angle;
  int currentFrameEnemy1=1;
  
  BasicEnemy(PVector pos, PVector dim, PVector vel){
    super(pos,vel,dim);    
    basicHealth = 2;
  }
  
  void update(PImage [] list){
    if(state == LEVEL_ONE){
      checkWallsLevel1();
    }
    if(state == LEVEL_TWO){
      checkWallsLevel2();
    }
    if(state == LEVEL_THREE){
      checkWallsLevel3();
    }
     if(state == BOSS){
      checkWallsBoss();
    }
    
    //Checks if the enemy hit the player
    for (int i=0; i<enemyList.size(); i++){
      BasicEnemy current = enemyList.get(i);
      hitCharacter(play);
    }
    if(frameCount%2 == 0||currentFrameEnemy1 == 0){ //Animation code like lab challenges except its divided by 2
      currentFrameEnemy1++;
    }
    if(currentFrameEnemy1 == list.length){ 
      currentFrameEnemy1=1;
    }
    
    if (basicHealth>0) drawMe(list); follow(300); move();
    if (basicHealth<0) enemyList.remove(this);
  }
  
  void follow(int threshold){ // Code I referred to from lecture 8
    if(abs(pos.x-play.pos.x)<threshold && abs(pos.y-play.pos.y)<threshold){ //If the enemy is close enough the player, it will follow the player
        angle = atan2(play.pos.y- pos.y, play.pos.x-pos.x); 
        PVector vel = PVector.fromAngle(angle);
        vel.mult(1.5); //At this speed
        pos.add(vel);
    }
  }
  
  //If the player successfully hit this enemy, the sound will play for it and the health will decrease
  //As long as the buffer is true.
  //The mouse must ne released again to reset the buffer to attack again
  void decreaseHealth(){
    buzz.play(0);
    if(hitBuffer==true) basicHealth--; beeKilled++; //Tallies the attack for achievement
    if(vel.x<0) pos.x+=30;
    if(vel.x>1) pos.x-=30;
    if(vel.y<0) pos.y+=30;
    if(vel.y>1) pos.y-=30;
  }
  
  //Different wall checking methods for each level
  //All reverse the enemies direction if a wall is hit
  void checkWallsLevel1(){
    if (pos.x<100) vel.x *= -1;
    if (pos.x>900) vel.x *= -1;
    if (pos.y<200) vel.y *= -1;
    if (pos.y>700) vel.y *= -1;
  }
  void checkWallsLevel2(){
    if (pos.x<130) vel.x *= -1;
    if (pos.x>1000) vel.x *= -1;
    if (pos.y<100) vel.y *= -1;
    if (pos.y>500) vel.y *= -1;
  }
  void checkWallsLevel3(){
    if (pos.x<100) vel.x *= -1; 
    if (pos.x>1000) vel.x *= -1; 
    if (pos.y<100) vel.y *= -1; 
    if (pos.y>700) vel.y *= -1;
    
    if (pos.x<50) pos.x+= 100;
    if (pos.x>1050) pos.x-= 100;
  }
  
  void drawMe(PImage [] list){ //Draws the enemy and flips it if it moves backwards
    pushMatrix();
    translate(pos.x, pos.y);
    if(vel.x>0){
      scale(-1,1);
    }
    image(list[currentFrameEnemy1],0,0);
    popMatrix();
    
    //pushMatrix();
    //translate(pos.x, pos.y);
    //int barSize = 50;
    //rectMode(CORNER);
    //strokeWeight(3);
    //fill(#FF6262);
    //stroke(#FF3E3E);
    //float newHealth = (float) basicHealth/2;
    //rect(-barSize/2,30, barSize*newHealth, 8);  
    //popMatrix();
    healthBar(50, basicHealth, -25,30, 2);
  }
  
}
