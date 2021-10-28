//This is a global sketch 
//It is used to store the gameplay for each level to make the main sketch less unorganized

//Gameplay for level 1
void gamePlayLevel1(){
    deadSong.pause();//Pauses the Main menu song
    song1.play();
    play.drawDashbar();
    play.drawHealthbar();
    object.drawItem(490,120,chest); //Draws the chest and checks if the player touched it
    if(object.check(play)){ //if the player touches the chest, the boolean is false
      touched = false;
    }
    
    //This is to check walls if the player collided with them
    for (int i = 0; i<wallsLevel1.size();i++){
      Walls w = wallsLevel1.get(i);
      w.drawMeLevel1();
      if(w.check(play)) play.stuck();
    }
    
    //This is the enemy loop to spawn and check walls for enemy collisions
    for (int i = 0; i<enemyList.size();i++){
      BasicEnemy e = enemyList.get(i);
      e.update(beeAni);
      for (int j = 0; j<wallsLevel1.size();j++){
        Walls w = wallsLevel1.get(j);
        if(w.check(e)) e.stuck(w);
      }
    }
  moving(); //Moves the character depending on keyboard command
}

void gamePlayLevel2(){
    song1.pause(); 
    song2.play(); 
    play.drawDashbar();
    play.drawHealthbar();
    object.drawItem(860,100,chest);
    if(object.check(play)){
      touched = false;
    }
    
    //since all the enemies were removed in the reset (in Player), the enemies are repawned
    //With a different amount of enemies
    if(enemyList.size()<1){
      for (int i = 0; i<5;i++){
        respawn();
      }
    }
    if(secondEnemyList.size()<1){
      for (int i = 0; i<3;i++){
        respawnSecond();
      }
    }
    
    //This is to check walls for the player
    for (int i = 0; i<wallsLevel2.size();i++){
      Walls w = wallsLevel2.get(i);
      w.drawMeRegular();
      if(w.check(play)) play.stuck();
    }
    
    //This is the enemy loop to spawn and check walls
    for (int i = 0; i<enemyList.size();i++){
    BasicEnemy e = enemyList.get(i);
    e.update(beeAni);
      for (int j = 0; j<wallsLevel2.size();j++){
        Walls w = wallsLevel2.get(j);
      }
    }
    for (int i = 0; i<secondEnemyList.size();i++){
    SecondEnemy e = secondEnemyList.get(i);
    e.update(spiderAni);
      for (int j = 0; j<wallsLevel2.size();j++){
        Walls w = wallsLevel2.get(j);
      }
    }
  moving();
  
  //This checks if the health power up is picked up and only draws if it is true
  //Once touched it is removed
  if (pickedUp==true){ 
    itemHealth.drawItem(535,380,health); //Draws it
    if(itemHealth.check(play)){ //Checks collision
      pickedUp = false;
      healthPickup++; //Increases achievment count
      if(pickedUp == false){
        play.increaseHealth(); //Increases health if touched
        powerup.play(0);
      }
    }
  }
  
  //draws the trees that were "hiding" the health pack
  image(tree,500,250);
  image(tree,575,250);
  image(tree,533,300);
  image(tree,500,350);
  image(tree,575,350);
}

void gamePlayLevel3(){ //Same code as gameplay 2 with more enemies and no health pack
    song2.pause();
    song3.play(); 
    play.drawDashbar();
    play.drawHealthbar();
    object3.drawItem(525,300,chest);
    if(object3.check(play)) touched = false;
    
    if(enemyList.size()<1){
      for (int i = 0; i<7;i++){
        respawn();
      }
    }
    if(secondEnemyList.size()<1){
      for (int i = 0; i<4;i++){
        respawnSecond();
      }
    }
    
    for (int i = 0; i<wallsLevel3.size();i++){
      Walls w = wallsLevel3.get(i);
      w.drawMeRegular();
      if(w.check(play)) play.stuck();
    }
    
    for (int i = 0; i<enemyList.size();i++){
    BasicEnemy e = enemyList.get(i);
    e.update(beeAni);
    for (int j = 0; j<wallsLevel3.size();j++){
      Walls w = wallsLevel3.get(j);
      if(w.check(e)) e.stuck(w);
      }
    }
    for (int i = 0; i<secondEnemyList.size();i++){
    SecondEnemy e = secondEnemyList.get(i);
    e.update(spiderAni);
    for (int j = 0; j<wallsLevel3.size();j++){
      Walls w = wallsLevel3.get(j);
      if(w.check(e)) e.stuck(w);
    }
  }
  moving();
}

void bossGameplay(){
  song3.pause();
  bossSong.play();
  play.drawDashbar();
  play.drawHealthbar();  
  boss.update(bossAni); //The line to draw the boss, rest of code is in class
    
    //Spawns enemies and stops spawning if all are killed because of the variable counting spawns
    for (int i = 0; i<2;i++){
      if (stopBasicSpawn>0) respawn(); stopBasicSpawn--;
    } 
    for (int i = 0; i<1;i++){
      if (stopSecondSpawn>0) respawnSecond(); stopSecondSpawn--;
    }
    
    //This is to check walls for the player
    for (int i = 0; i<bossWalls.size();i++){
      Walls w = bossWalls.get(i);
      w.drawMeRegular();
      if(w.check(play)) play.stuck();
    }
    
    //This is the enemy loop to spawn and check walls
    for (int i = 0; i<enemyList.size();i++){
    BasicEnemy e = enemyList.get(i);
    e.update(beeAni);
      for (int j = 0; j<bossWalls.size();j++){
        Walls w = bossWalls.get(j);
        if(w.check(e)) e.stuck(w);
      }
    }
    for (int i = 0; i<secondEnemyList.size();i++){
    SecondEnemy e = secondEnemyList.get(i);
    e.update(spiderAni);
      for (int j = 0; j<bossWalls.size();j++){
        Walls w = bossWalls.get(j);
        if(w.check(e)) e.stuck(w);
      }
    }
    
    moving();
    
    //Another health pack
    if (pickedUpBoss==true){
    itemHealthBoss.drawItem(300,520,health);
    if(itemHealthBoss.check(play)){
      pickedUpBoss = false;
      healthPickup++;
      if(pickedUpBoss == false){
        play.increaseHealth();
        powerup.play(0);
      }
    }
  }
}
