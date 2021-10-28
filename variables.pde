//All variables declared or initialized in main sketch
import ddf.minim.*;
import controlP5.*;

float speed = 2;
int energy = 120;
int dash = 5;
int maxHealth = 15; //Player max health
float playerHealth = maxHealth;
int currentFrameMain = 1; //Main menu animation
int stopBasicSpawn=2; //For the boss level to stop spaning enemies once they all die
int stopSecondSpawn=1;//For the boss level to stop spaning enemies once they all die
int dashCounter = 1; //to maintain energy decrease
int endScreen=120; //The black screen when game in won

//Counters for achievements
int healthPickup = 0;
int beeKilled = 0;
int spiderKilled = 0;
int bossKilled = 0;

//Images
PImage level1;
PImage level2;
PImage level3;
PImage bossBg;
PImage dead;
PImage chest;
PImage sword;
PImage healthBar;
PImage tree;
PImage health;
PImage web;
PImage instructions;
PImage introStory;
PImage level1Story;
PImage level2Story;
PImage level3Story;
PImage end;
PImage beePic;
PImage spiderPic;
PImage bossPic;

boolean hitBuffer = true; //So health does not decrease too fast
boolean dashBuffer = true;//So energy does not decrease too fast
boolean pickedUp = true; //If you collected the helath pack
boolean pickedUpBoss = true;//If you collected the health pack on the boss level
boolean touched = true; //If player touched an item chest or health pack
boolean up,left,down,right, space, click; //Interactions

//Keyboard movements
PVector upAcc = new PVector(0, -speed);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);
PVector downAcc = new PVector(0,speed);

//BGMs
final String LEVEL_1_SONG = "bgm/Shrunk 1.mp3"; //This song was downloaded online through the YouTuber SeaOfPixels's video "Minecraft Full Complete Soundtrack 2020 [V3]" at 4:32:21 on April 5 2021. Then edited through Premiere Pro by Samantha Chung
final String LEVEL_3_SONG = "bgm/Kirby Stars.mp3"; //This song was downloaded online through the YouTuber Tenpers Universe's video "30 minutes of kirby music to make you feel better" at 22:36 Twinkle Stars on April 10 2021. Then edited through Premiere Pro by Samantha Chung
final String LEVEL_2_SONG = "bgm/Kirby Ocean.mp3"; //This song was downloaded online through the YouTuber Commander Jersey's video "Happy Kirby Music Mix" at 21:00 Onion Ocean 2 on April 10 2021. Then edited through Premiere Pro by Samantha Chung
final String BOSS_SONG = "bgm/Excalibur 1.mp3"; //This song was downloaded online through the YouTuber SeaOfPixels's video "Minecraft Full Complete Soundtrack 2020 [V3]" at 4:45:08 on April 5 2021. Then edited through Premiere Pro by Samantha Chung
final String DEAD_SONG = "bgm/Dead.mp3"; //This song was downloaded online through the YouTuber Dezphos's video "1AM (Extended) - Animal Crossing: New Leaf Music" on April 5 2021

//Sound effects
final String buzzSound = "Sound Effects/Bee.mp3";//This sound was downloaded online through the YouTuber Sound Effect's video "Bumblebee - @Sound Effect" on April 12 2021. Then edited through Premiere Pro by Samantha Chung
final String spraySound = "Sound Effects/Spray.mp3";//This sound was downloaded online through the YouTuber Sound Effects & More's video "pray bottle - Sound effects" on April 12 2021. Then edited through Premiere Pro by Samantha Chung
final String crackSound = "Sound Effects/Crack.mp3";//This song was downloaded online through the YouTuber Sound Effect's video "Bone Crack Sound Effect" on April 12 2021. Then edited through Premiere Pro by Samantha Chung
final String whooshSound = "Sound Effects/Whoosh.mp3";//This sound was downloaded online through the YouTuber [Sans titre]'s video "Whoosh sound effect" on April 12 2021. Then edited through Premiere Pro by Samantha Chung
final String quackSound = "Sound Effects/Quack.mp3";//This song was downloaded online through the YouTuber Schurikenz's video "Quack Sound Effect" on April 12 2021. Then edited through Premiere Pro by Samantha Chung
final String clickSound = "Sound Effects/Click.mp3";//This song was downloaded online through the YouTuber oopsieaniee's video "CUTE + AESTHETIC SOUND EFFECTS PACK | sfx that I use for edits (no copyright)" on April 13 2021. Then edited through Premiere Pro by Samantha Chung
final String hurtSound = "Sound Effects/Chop.mp3";//This song was downloaded online through the YouTuber Audio Library's video "Chop / Sound Effect" on April 13 2021. Then edited through Premiere Pro by Samantha Chung
final String powerupSound = "Sound Effects/Health.mp3";//This song was downloaded online through the YouTuber keanu otocladding's video "Sound Effect - Bloop Cartoon" on April 13 2021. Then edited through Premiere Pro by Samantha Chung

int state;
final int INTRO = 0; // This stage is the beginning to show the story
final int END = 1; // This is the end of the game when you win
final int LEVEL_ONE = 2; // This is the playing level 1
final int LEVEL_ONE_END = 3; // This is the screen when you complete/win level 1
final int LEVEL_TWO = 4; // This is the playing level 2
final int LEVEL_TWO_END = 5; // This is the screen when you complete/win level 2
final int LEVEL_THREE = 6; // This is the playing level 3
final int LEVEL_THREE_END = 7; // This is the screen when you complete/win level 3
final int DIED = 8; //This is the screen whenever you die
final int BOSS = 9; //Boss level
final int MAIN = 10;//The first screen
final int INSTRUCTION = 11;//this shows how to play
 
 //Character animations
PImage[] characterBack = new PImage[5];
PImage[] characterFront = new PImage[5];
PImage[] characterSide = new PImage[5];

//enemy animations
PImage[] spiderAni = new PImage[4];
PImage[] beeAni = new PImage[4];
PImage[] bossAni = new PImage [7];

//Main menu animation
PImage[] main = new PImage[9];

//List for walls
ArrayList<Walls> wallsLevel1 = new ArrayList<Walls>();
ArrayList<Walls> wallsLevel2 = new ArrayList<Walls>();
ArrayList<Walls> wallsLevel3 = new ArrayList<Walls>();
ArrayList<Walls> bossWalls = new ArrayList<Walls>();

//List for enemies
ArrayList<BasicEnemy> enemyList = new ArrayList<BasicEnemy>();
ArrayList<SecondEnemy> secondEnemyList = new ArrayList<SecondEnemy>();
