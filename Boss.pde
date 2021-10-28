//The final boss of the game is a duck
//It shoots eggs at the player 
//It can 'fly' sicne the obstacles do not apply to it
//also on the eggs damage the player, touching to body will not effect the player
//Most code is in MovingObject and is similar to BasicEnemy. Just modified

class Boss extends MovingObject{
  
  int currentFrameBoss=1;
  int bossHealth = 20;
  
  //This is the containment/aggregation
  //Both projectiles are subclasses of MovingObject but this arraylist braches objects from Projectile to Boss
  ArrayList<Projectile> proj = new ArrayList<Projectile>();
  
  Boss(PVector pos, PVector dim,PVector vel){
    super(pos,vel,dim);
  }
  
  void update(PImage [] list){
    super.update();
    checkWallsBoss();
    
    if(frameCount%5 == 0||currentFrameBoss == 0){
      currentFrameBoss++;
    }
    if(currentFrameBoss == list.length){ 
      currentFrameBoss=1;
    }
    
    drawMeBoss(list);
    checkProjectiles();
    if(frameCount%60==0&&bossHealth>0){
      fire();
      crack.play(0);
    }
    if(bossHealth<0) state=END;
  }
  
  void drawMeBoss(PImage [] list){
    pushMatrix();
    translate(pos.x, pos.y);
    if(vel.x>0){
      scale(-1,1);
    }
    image(list[currentFrameBoss],0,0);
    popMatrix();
    
    healthBar(150, bossHealth, -75,60, 20);
    //int barSize = 15;
    //rectMode(CORNER);
    //strokeWeight(3);
    //fill(#FF6262);
    //stroke(#FF3E3E);
    //float newHealth = (float) bossHealth/2;
    //rect(-75,30, barSize*newHealth, 8);  
    //popMatrix();
  }
  
  void fire() {
    proj.add(new Projectile(new PVector(pos.x, pos.y), new PVector(abs(-5*PI/10),abs(-5*PI/10)),new PVector(30,50)));
  }
  
  void checkProjectiles(){
    for (int i=0; i<proj.size(); i++) {
      Projectile p = proj.get(i);
      p.update();
      p.drawMe();
      if(abs(p.pos.x-play.pos.x)<p.dim.x/2+play.dim.x/2 && abs(p.pos.y-play.pos.y)<p.dim.y/2+play.dim.y/2){
        proj.remove(i);
        playerHealth--;
      }
    }
  }
  void decreaseHealth(){
    quack.play(0);
    if(hitBuffer==true) bossHealth--; 
    if(vel.x<0) pos.x+=30;
    if(vel.x>1) pos.x-=30;
    if(vel.y<0) pos.y+=30;
    if(vel.y>1) pos.y-=30;
  }
}
