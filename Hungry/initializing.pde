//All the images that get loaded in the main sketch

void loadValues(){
  instructions= loadImage("backgrounds/Instructions.jpg"); //Image was made by Samantha Chung in Photoshop on April 12 2021. Original file is in the data folder
  instructions.resize(1100,800); 
  level1= loadImage("backgrounds/Level 1.png"); //Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  level1.resize(1100,800);
  level2= loadImage("backgrounds/Level 2.png"); //Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  level2.resize(1100,800);
  level3= loadImage("backgrounds/Level 3.png"); //Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  level3.resize(1100,800); 
  bossBg= loadImage("backgrounds/Boss.jpg"); //Image was made by Samantha Chung in Photoshop on April 12 2021. Original file is in the data folder
  bossBg.resize(1100,800); 
  dead = loadImage("backgrounds/Dead.png"); //Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  dead.resize(1100,800);
  chest = loadImage("Items/chest.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  chest.resize(75,65);
  tree = loadImage("backgrounds/tree.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  tree.resize(115,135);
  healthBar = loadImage("Player/healthbar.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  healthBar.resize(375,375);
  health = loadImage("Items/Health.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  health.resize(75,65);
  sword = loadImage("Player/Sword.png");//Image was made by Samantha Chung in Photoshop on April 12 2021. Original file is in the data folder
  sword.resize(60,80);
  introStory = loadImage("Story/Intro.jpg");//Comic was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
  introStory.resize(1100,800);
  level1Story = loadImage("Story/Level 1 end.jpg");//Comic was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
  level1Story.resize(1100,800);
  level2Story = loadImage("Story/Level 2 end.jpg");//Comic was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
  level2Story.resize(1100,800);
  level3Story = loadImage("Story/Level 3 end.jpg");//Comic was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
  level3Story.resize(1100,800);
  end = loadImage("Story/end.jpg");//Comic was made by Samantha Chung in Photoshop on April 10 2021. Original file is in the data folder
  end.resize(1100,800);
  beePic = loadImage("Enemy 1/Bee Side_0.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  beePic.resize(75,55);
  spiderPic = loadImage("Enemy 2/spider_0.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  spiderPic.resize(95,75);
  bossPic = loadImage("Boss/Boss_0.png");//Image was made by Samantha Chung in Photoshop on April 3 2021. Original file is in the data folder
  bossPic.resize(105,85);
  
  
  minim = new Minim(this);
  
  //BGM songs
  song1 = minim.loadFile(LEVEL_1_SONG);
  song2 = minim.loadFile(LEVEL_2_SONG);
  song3 = minim.loadFile(LEVEL_3_SONG);
  bossSong = minim.loadFile(BOSS_SONG);
  deadSong = minim.loadFile(DEAD_SONG);
  
  //Sound effects
  buzz = minim.loadFile(buzzSound); //For bees
  whoosh = minim.loadFile(whooshSound); //For attacking
  spray = minim.loadFile(spraySound); //For spiders
  crack = minim.loadFile(crackSound); //For eggs projectiles
  quack = minim.loadFile(quackSound); //for boss getting hit
  chop = minim.loadFile(hurtSound); //For player getting hit
  powerup = minim.loadFile(powerupSound); //For player getting hit
  
  PFont font = createFont("GillSans",25 );
  //Sound when clicked
  clik = minim.loadFile(clickSound);
  //all have the same colour and font but needed to re instantiate to apply different functions
  //"start" button
  start.getCaptionLabel().setFont(font);
  start.setColorForeground(color(#528ca2));
  start.setColorBackground(color(#377187));
  //"replay button
  replay.getCaptionLabel().setFont(font);
  replay.setColorForeground(color(#528ca2));
  replay.setColorBackground(color(#377187));
  //">" button
  continu.getCaptionLabel().setFont(font);
  continu.setColorForeground(color(#528ca2));
  continu.setColorBackground(color(#377187));
  
  play = new Player(new PVector(900,920), new PVector(75,100)); // For Player 
  boss = new Boss(new PVector(450,200), new PVector(200,160),new PVector(random(-5,5), random(-5,5))); //adds boss
  object = new Chest(new PVector(490,120), new PVector(75,65)); //For chest
  object3 = new Chest(new PVector(525,300), new PVector(75,65)); //For chest in level 3 (I made this because it would be easier than creating a boundary box in Player)
  itemHealth = new HealthPowerUp(new PVector(535,380), new PVector(75,65)); //For health powerup
  itemHealthBoss = new HealthPowerUp(new PVector(300,520), new PVector(75,65)); //For health powerup in boss level (since I had to re position
  
  //Adds blocks to a list for level 1
  wallsLevel1.add(new Walls(new PVector(200,300), new PVector(75,100)));
  wallsLevel1.add(new Walls(new PVector(925,525), new PVector(50,75)));
  wallsLevel1.add(new Walls(new PVector(350,650), new PVector(100,50)));
  
  //Adds blocks to a list for level 2
  wallsLevel2.add(new Walls(new PVector(350,70), new PVector(700,175)));
  wallsLevel2.add(new Walls(new PVector(50,400), new PVector(130,800)));
  wallsLevel2.add(new Walls(new PVector(730,700), new PVector(730,300)));
  
  //Adds blocks to a list for level 3
  wallsLevel3.add(new Walls(new PVector(525,193), new PVector(350,33)));
  wallsLevel3.add(new Walls(new PVector(800,290), new PVector(200,33)));
  wallsLevel3.add(new Walls(new PVector(712,287), new PVector(33,220)));
  wallsLevel3.add(new Walls(new PVector(390,380), new PVector(700,33)));
  wallsLevel3.add(new Walls(new PVector(740,550), new PVector(650,33)));
  
  //Adds blocks to a list for boss level
  bossWalls.add(new Walls(new PVector(295,420), new PVector(250,100)));
  bossWalls.add(new Walls(new PVector(810,420), new PVector(250,100)));
}
