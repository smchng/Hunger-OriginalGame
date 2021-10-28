//This is a child class of the basic enemy
//Code is copied from  BasicEnemy but modified for second enemy
//Rest of the code BasicEnemy applies to this as well
//Essentially has the same properties exept it was a different health

class SecondEnemy extends BasicEnemy{
  
  PImage spider;
  int secondHealth;
  int currentFrameEnemy2=1;
  
  SecondEnemy(PVector pos, PVector dim, PVector vel){
    super(pos,dim,vel);
    
    secondHealth = 4;
  }
  
  void update(PImage [] list){
    if(state == LEVEL_TWO){
      checkWallsLevel2();
    }
    if(state == LEVEL_THREE){
      checkWallsLevel3();
    }
    if(state == BOSS){
      checkWallsBoss();
    }
    
    for (int i=0; i<secondEnemyList.size(); i++){ //checks if it ever collides with player
      BasicEnemy current = secondEnemyList.get(i);
      hitCharacter(play);
    }
    
    if(frameCount%6 == 0||currentFrameEnemy2 == 0){
      currentFrameEnemy2++;
    }
    if(currentFrameEnemy2 == list.length){ 
      currentFrameEnemy2=1;
    }
    
    if (secondHealth>0) drawMe(list); follow(325); move();
    if (secondHealth<0) secondEnemyList.remove(this);
  }
  
  void decreaseHealth(){
    spray.play(0);
    if(hitBuffer==true) secondHealth--; spiderKilled++; 
    if(vel.x<0) pos.x+=30;
    if(vel.x>1) pos.x-=30;
    if(vel.y<0) pos.y+=30;
    if(vel.y>1) pos.y-=30;
  }
  
  void drawMe(PImage [] list){
    pushMatrix();
    translate(pos.x, pos.y);
    if(vel.x>0){
      scale(-1,1);
    }
    image(list[currentFrameEnemy2],0,0);
    popMatrix();
    
    healthBar(80,secondHealth, -40,40,4);
    
    //int barSize = 40;
    //rectMode(CORNER);
    //strokeWeight(3);
    //fill(#FF6262);
    //stroke(#FF3E3E);
    //float newHealth = (float) secondHealth/2;
    //rect(-35,30, barSize*newHealth, 8);  
    //popMatrix();
  }
}
