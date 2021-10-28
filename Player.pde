//This is the player class that manipulates the images to key commands
//It has the draw character and healthbar methods, movement controls and decreases the health if it attacks an enemy

class Player{
  
  PVector pos, vel, acc, dim;
  float damp = 0.6;
  int currentFrame=1;
  int health = 20;
  boolean reposition = true ;//to move player to correct spot in next level
  
  //Boss boss = new Boss(new PVector(450,200), new PVector(200,160),new PVector(random(-5,5), random(-5,5))); //adds boss to detet collision CONTAINMENT
  
  Player(PVector pos, PVector dim){
    this.pos = pos;
    this.dim =dim;
    vel = new PVector();
  }
  
  void update(PImage [] list){
    move();
    if(playerHealth<0){ 
      playerHealth=0;   
      state = DIED; //changes state if you run out of health
    }
    
    //Wall detection and start positions depending on state
    if (state==LEVEL_ONE){
      checkLevel1Walls();
      if (pos.x>400&&pos.x<600&&pos.y<200&&mousePressed&&touched==false){ //If the player is within the boundaries and clicks, it will switch states
        state = LEVEL_ONE_END;
        reset(); //Resets all enemies (not global method)
        reposition =false; //To reposition player for next level
        touched = true;
      }
    }
    if(state == LEVEL_TWO){
      checkLevel2Walls();
      if(reposition == false){
        pos.x=220;
        pos.y=690;
        reposition = true;
      }
      if (pos.x>800&&pos.x<1000&&pos.y<150&&mousePressed&&touched==false){
        state = LEVEL_TWO_END;
        reset();
        reposition =false;
        touched = true;
      }
    }
    if(state == LEVEL_THREE){
      checkLevel3Walls();
      if(reposition == false){
        pos.x=900;
        pos.y=920;
        reposition = true;
      }
      if (mousePressed&&touched==false){
        state = LEVEL_THREE_END;
        reset();
        reposition =false;
      }
    }
    if(state == BOSS){
      checkLevelBossWalls();
      if(reposition == false){
        pos.x=width/2;
        pos.y=height-dim.y;
        reposition = true;
      }
    }
    
    //Animation
    if(frameCount%8 == 0||currentFrame == 0){
      currentFrame++;
    }
    if(currentFrame == list.length){ 
      currentFrame=1;
    }
    
    //Draws the character depending on frame
    drawMe(list);
    
    //If the player clicks it draws the scord, checks if it hit anything and plays sound
    if(click){
      whoosh.play(0);
      drawAttack();
      for (int i=0;i<enemyList.size();i++){
        BasicEnemy e = enemyList.get(i);
        hitEnemy(e);
      }
      for (int i=0;i<secondEnemyList.size();i++){
        BasicEnemy e = secondEnemyList.get(i);
        hitEnemy(e);
      }
      if(state==BOSS) hitBoss(boss);
    }
  }
  
  void move(){
    pos.add(vel);
    vel.mult(damp);
  }
  void acc(PVector force) {
    vel.add(force);
  }
  
  //If player collides with anything typed BasicEnemy
  //Inclusion polymorphism, it detects both the basic and second enemy
  void hitEnemy(BasicEnemy e){
    if(abs(pos.x-e.pos.x)<dim.x/2+e.dim.x/2 && abs(pos.y-e.pos.y)<dim.y/2+e.dim.y/2){
      e.decreaseHealth();
      hitBuffer = false; //the health buffer
    }
  }
  
  //If the player hits the boss
  void hitBoss(Boss e){
    if(abs(pos.x-e.pos.x)<dim.x/2+e.dim.x/2 && abs(pos.y-e.pos.y)<dim.y/2+e.dim.y/2){
      e.decreaseHealth();
      hitBuffer = false;
    }
  }
  
  //Removes all enemies for next level
  void reset(){
    enemyList.removeAll(enemyList);
    secondEnemyList.removeAll(secondEnemyList);
  }
  
  //For health packs
  void increaseHealth(){
    playerHealth+=5;
  }
  
  //Draws the character depending on frame
  void drawMe(PImage[] list){
    pushMatrix();
    translate(pos.x,pos.y);
    if(vel.x>0){
      scale(-1,1);
    }
    image(list[currentFrame], 0, 0);
    popMatrix();
  }
  
  //Draws the player health bar
  void drawHealthbar(){
    int barSize = 700;
    pushMatrix();
    scale(0.35);
    translate(0,0);
    rectMode(CORNER);
    strokeWeight(5);
    fill(#6be371);
    stroke(#65d36a);
    float newHealth = (float) playerHealth/maxHealth;
    rect(325,155, barSize*newHealth, 80);  
    image(healthBar,250,200);
    popMatrix();
  }
  //Draws the player stamina bar for dashing
  void drawDashbar(){
    int barSize = 500;
    pushMatrix();
    scale(0.35);
    translate(0,0);
    rectMode(CORNER);
    strokeWeight(5);
    fill(#83ABFF);
    stroke(#5A8FFF);
    float dashHealth = (float) dash/5;
    rect(325,255, barSize*dashHealth, 50);  
    popMatrix();
  }
  
  //Draws the player sword when clicked
  void drawAttack(){
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(0);
    if(vel.x>0){
      scale(-1,1);
    }
    image(sword,-35,-5);
    popMatrix();
  }
  
  //Multiple wall checkings again
  void checkLevel1Walls(){
    if (pos.x<100) pos.x = 100;
    if (pos.x>1000) pos.x = 1000;
    if (pos.y>700) pos.y = 700;
    if (pos.y<100) pos.y = 100;
    
    if(pos.y<200&&pos.x<400){
      if(up) pos.y = 200;
      if(left) pos.x = 400;
    }
    if(pos.x>600&&pos.y<220){
      if(up) pos.y = 200;
      if(left) pos.x = 600;
    }
  }
  void checkLevel2Walls(){
    if (pos.x<50) pos.x = 50;
    if (pos.x>1050)pos.x = 1050;
    if (pos.y<50) pos.y = 50;
    if (pos.y>750) pos.y = 750;
  }
  void checkLevel3Walls(){
    if (pos.x<100) pos.x = 100;
    if (pos.x>1000)pos.x = 1000;
    if (pos.y<100) pos.y = 100;
    if (pos.y>700) pos.y = 700;
  }
  void checkLevelBossWalls(){
    if (pos.x<50) pos.x = 100;
    if (pos.x>1000)pos.x = 1000;
    if (pos.y<100) pos.y = 100;
    if (pos.y>750) pos.y = 700;
  }
  
  //Physics for obstacle collisions
  void stuck(){
    if (vel.y <0) pos.y += 5; 
    if (vel.x <0) pos.x += 5;
    if (vel.y >1) pos.y -= 5;
    if (vel.x >1) pos.x -= 5; 
    
  }
}
