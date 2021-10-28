//Samantha Chung D101
//301426865

/*
My game is an action game. You play as a hungry onion who is looking for food
There are 3 levels that you must complete in order to reach the final boss level 
Each enemy has a different health value. Spiders and bees follow you and the boss shoots eggs at you
In order to attack, you will press the mouse button and if you hit an enemy they will bounce back (physics)
it will only decrease helath once. So, you cannot hold the mouse and run around. This also allows only 1 health point to decrease
The 3 different levels have different maps and obstacles you cannot walk over.
To complete the level, you need you reach the chest and click it. This will lead to the story cutscene
In some levels, you will get food packs to restore your health
You can also dash by clicking the spacebar but you only have a limited amount until you regain energy

There are 4 achievements. If you kill 30 bees, 25 spiders, finish the game in under 3 minutes and completing the game without using health powerups

All moving animals are animated and when the player hits them, a sound will play (since there are 5, some might not be heard or drown another sound out)
There are also 5 different BGMs depenidg on the level. They use .play() to  play though since calling the sound in draw will cause it to repeat the first second constantly

The wall collision will sometimes cause the player to move up or to the side even though they do not intended to.
This was a bug at first but I thought its a good way to incorporate the environment as an obstacle too
For example in level 2, sometimes you can get stuck in the trees and the only way to get out is to dash out. 
To me, this seems like a challenge the player needs to figure out instead since escaping is still possible

One more note is the "GillsSans" font not found. I first chose GillSans but the font would not load but after I think the substitute font loaded works well too. So I left it

I have 5 animations, boss, enemy 1, enemy 2, character and main menu image
Each have their own sound effect when player attacks them and if player is attacked
The 2 superclasses are MovingObjects and Items
MovingObjects = BasicEnemy, Projectiles, Boss
Items = Health and Chest
BasicEnemy is a subclass from MovingObject but SecondEnemy is a subclass of BasicEnemy
update(), drawMe(), decreaseHealth() and drawItem() are overridden methods
In Player, the method hitEnemy() takes in anything typed BasicEnemy so, it accounts for both enemies spiders and bees.
Containment is in Boss it hold an arraylist for projectiles which both classes extends MovingObject
*/

Player play;
Boss boss;
BasicEnemy enemy1;
Items object, object3, itemHealth, itemHealthBoss; //One for the chest and another for the health powerup
Minim minim;
AudioPlayer song1, song2,song3, bossSong,deadSong, buzz,crack,quack,whoosh,spray,clik,chop,powerup;
ControlP5 p5;
Button start, replay, continu;

void setup(){
  size (1100,800);
  
  p5 = new ControlP5(this);
  start = p5.addButton("s t a r t",0,850, 700,175,50);
  replay = p5.addButton("r e p l a y",0,850, 700,175,50);
  continu = p5.addButton(">",0,985, 700,50,50);
  
  for (int i=0;i<7;i++){ //The first level only has these many enemies so it adds only 7 to the list
    enemyList.add(new BasicEnemy(new PVector(random(100,800),random(200,700)), new PVector(100,75),new PVector(random(-3,3), random(-3,3))));
  }
  
  loadFrames(); //Loads values and variables from another tab
  loadValues(); //Loads all the images from another tab
    
  state = MAIN;
}

void draw(){
  switch(state){
    case LEVEL_ONE:
      cutscreen(level1);
      gamePlayLevel1();
    break;
    case LEVEL_ONE_END:
    p5.getController(">").show();
    cutscreen(level1Story); 
    break;
    case LEVEL_TWO:
      cutscreen(level2);
      gamePlayLevel2();
    break;
    case LEVEL_TWO_END:
    p5.getController(">").show();
    cutscreen(level2Story);
    break;
    case LEVEL_THREE:
      cutscreen(level3);
      gamePlayLevel3();
    break;
    case LEVEL_THREE_END:
    p5.getController(">").show();
    cutscreen(level3Story);
    break;
    case DIED:
    p5.getController("r e p l a y").show();
    cutscreen(dead);
    song1.pause(); //This is just a grab all so no matter what song is playing it will pause if you die
    song2.pause();
    song3.pause();
    bossSong.pause();
    deadSong.play();
    break;
    case INTRO:
    p5.getController(">").show();
    cutscreen(introStory);
    break;
    case MAIN:
    p5.getController("r e p l a y").hide();
    p5.getController(">").hide();
    animate(main);
    deadSong.play();
    cutscreen(main[currentFrameMain]);
    break;
    case END:
    bossSong.pause();
    deadSong.play();
    endScreen--; //This shows a black screen to let the player know they won before show end screen
    background(100);
    if(space||endScreen<0){
      cutscreen(end);
      p5.getController("r e p l a y").show();
    }
    break;
    case BOSS:
    cutscreen(bossBg);
    bossGameplay();
    break;
    case INSTRUCTION:
    p5.getController(">").show();
    cutscreen(instructions);
    break;
  }
  //Shows sticker if achivement is reached
  if (beeKilled>60) image(beePic, 80,750);  //If 30 bees are killed (since each has a health of 2, this counts how many times it was hit)
  if (spiderKilled>100) image(spiderPic, 180,750);//If 25 spiders are killed (since each has a health of 4, this counts how many times it was hit)
  if (state==END&&((millis()/1000)/60)<3) image(bossPic, 300,750); //If the game is completed in under 3 minutes
  if (state == END && healthPickup <=0) image(health, 400,750); //If you complete the game without using any health powerups
}

void reset(int e, int x, float y){ //Resets everything if you choose to play again
  dash=5;
  pickedUp=true;
  pickedUpBoss=true;
  stopBasicSpawn=2; //For the boss level to stop spawning enemies once they all die
  stopSecondSpawn=1;//For the boss level to stop spawning enemies once they all die
  playerHealth = maxHealth;
  boss.bossHealth=20;
  beeKilled = 0;
  spiderKilled = 0;
  play = new Player(new PVector(x,y), new PVector(75,100)); // For Player to spawn
  enemyList.removeAll(enemyList);
  secondEnemyList.removeAll(secondEnemyList);
  if(enemyList.size()<1){ //Since you start at level one again, it spawns the bees again
      for (int i = 0; i<e;i++){
        respawn();
      }
    }
}

void respawn(){ //Spawns the bees
   enemyList.add(new BasicEnemy(new PVector(random(100,800),random(200,500)), new PVector(100,75),new PVector(random(-3,3), random(-3,3))));
  }

void respawnSecond(){ //Spawns the spiders
    secondEnemyList.add(new SecondEnemy(new PVector(random(100,800),random(200,500)), new PVector(100,75),new PVector(random(-3,3), random(-3,3))));
  }

void animate(PImage [] list){ //Handles all the animations of all characters
  if(frameCount%15 == 0||currentFrameMain == 0){
    currentFrameMain++;
    }
  if(currentFrameMain == list.length){ 
    currentFrameMain=1;
  }
}

void loadFrames(){ //Same style code like the lecture example except I added resize as variables to fit all images
    loadFrames(characterBack, "Player/back_character_",150,125);//Images were made by Samantha Chung in Photoshop on April 30 2021. Original file is in the data folder
    loadFrames(characterFront, "Player/character_",150,125);//Images were made by Samantha Chung in Photoshop on April 30 2021. Original file is in the data folder
    loadFrames(characterSide, "Player/side_character_",150,125);//Images were made by Samantha Chung in Photoshop on April 30 2021. Original file is in the data folder
    
    loadFrames(spiderAni, "Enemy 2/spider_",95,75);//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
    loadFrames(beeAni, "Enemy 1/Bee Side_",75,55);//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
    loadFrames(bossAni, "Boss/Boss_",200,160);//Image was made by Samantha Chung in Photoshop on April 12 2021. Original file is in the data folder
    
    loadFrames(main, "Story/Main_",1100,800);//Image was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
}
  
void loadFrames(PImage[] frame, String name, int x, int y){ //Same code that I referred to from lab challenge 10 and 11
  for(int i = 1; i< frame.length;i++){
    PImage f = loadImage(name+i+".png");
    pushMatrix();
    imageMode(CENTER);
    f.resize(x,y);
    popMatrix();
    frame[i] = f;
  }
}

void cutscreen(PImage img){ //For states to show the right background images
  image(img,width/2,height/2);
}

//Method for button
//shows and directs program to right state depending on the current state so a button can be used multiple times
void controlEvent(ControlEvent theEvent){
  if(theEvent.getController().getName()=="s t a r t"){
    clik.play(0);
    p5.getController("s t a r t").hide();
    if (state == MAIN) state = INTRO;
  }
  if(theEvent.getController().getName()=="r e p l a y"){
    clik.play(0);
    p5.getController("r e p l a y").hide();
    if (state==DIED||state==END) reset(7,900,920); state = INTRO;
  }
  if(theEvent.getController().getName()==">"){
    clik.play(0);
    p5.getController(">").hide();
    if (state == INSTRUCTION) state = LEVEL_ONE;
    if (state == INTRO) state = INSTRUCTION;
    if (state == LEVEL_ONE_END) state = LEVEL_TWO;
    if (state == LEVEL_TWO_END) state = LEVEL_THREE;
    if (state == LEVEL_THREE_END) state = BOSS;
  }
}

//Moves the character (called in gameplay methods)
void moving(){
  //Code to maintain dashing
  energy--;// A counter to increase the stamina required to dash
  if (energy<0){ //The counter is so dash only increases slowly
    if(dash<5) dash++;
    energy = 120;
  }
  //Once space is pressed the character will move forward as long as there is enough stamina
  if (space&&dash>0){
    if (dashBuffer==true) dash--; dashCounter--; //the stamina will decrease as long as the buffer is true. This stops it from decreasing too fast
    if (dashCounter<0.85) dashBuffer=false; dashCounter = 1; //The counter works to change the boolean to control how much decreases
    if (play.vel.y <0) play.pos.y -= 10; //Depending on how the character is moving, the player will dash in that direction
    if (play.vel.y >1) play.pos.y += 10; 
    if (play.vel.x <0) play.pos.x -= 10; 
    if (play.vel.x >1) play.pos.x += 10;
  }
  
  //Regular code to walk character
  if (left) play.acc(leftAcc);
  if (right) play.acc(rightAcc);
  if (up) play.acc(upAcc); 
  if (down) play.acc(downAcc); 
  
  //Code to animate the character depending on the directions it is movin gin
  if (!up&&!down&&!right&&!left) play.update(characterFront); //This animates my images depending on the key pressed
  if (up) play.update(characterBack);  
  if (down) play.update(characterFront);
  if (right) play.update(characterSide);
  if (left) play.update(characterSide);
  
}

void mousePressed(){
  click = true; //Used later to attack enemies
}

void mouseReleased(){
  click = false;
  hitBuffer = true; //This is an attack buffer for enemies so one click is only 1 health decrease
}

void keyPressed() {
  if (key == ' ') space = true;
  if (keyCode == 'W') up = true; 
  if (keyCode == 'A') left = true; 
  if (keyCode == 'D') right = true; 
  if (keyCode == 'S') down = true; 
}
void keyReleased() {
  if (key == ' ') space = false; dashBuffer = true;
  if (keyCode == 'W') up = false;
  if (keyCode == 'A') left = false;
  if (keyCode == 'D') right = false;
  if (keyCode == 'S') down = false;
}
