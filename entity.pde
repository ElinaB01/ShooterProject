ArrayList<Entity> enemies;

Entity player;

int eliminated = 0;

class Entity {
  int lives = 5;
  String type;
  PImage sprite;
  float x, y;
  float speedX, speedY;
  int hitpoints, scoreGain; // how much score is gained for destroying this enemy
  boolean active, destroyed;
  int fireRate, lastFire; // Vaenlase tulistamise intervall ja ajastus
  int lastHitTime = 0;  // Aeg, millal mängija viimati pihta sai
  
  final int STATE_PLAYING = 0;
  final int STATE_GAME_OVER = 1;
  final int STATE_MENU = 2;
  int gameState = STATE_MENU;
  
  public Entity(String type, int hitpoints, int scoreGain, PImage img, float x, float y, float speedX, float speedY) {
    this.type = type;
    this.hitpoints = hitpoints;
    this.scoreGain = scoreGain;
    this.sprite = img;
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    
    if (!type.equals("player")) {
      fireRate = (int)random(2000, 5000); // Vaenlased tulistavad iga 2-5 sekundi tagant
      lastFire = millis();
    }
  }
  
  public void update() {
    // TODO:
    // animations
    // visual feedback when damage is taken
    // explode on death, damaging nearby planes (player included)
    // have enemies shoot at the player
    
    if (type.equals("player")) {
        checkPlayerCollision();
        checkEntityCollision();
    } else {
        y += speedY;
        destroyed = y > height || checkCollision();

        if (millis() - lastFire >= fireRate) {
            enemyFire();
            lastFire = millis();
            if (frameCount % 90 == 0 && random(1) < 0.3) { 
              enemyFire();
            }
        }
    }
}

  private void enemyFire() {
    projectiles.add(new Projectile("enemy_bullet", x + sprite.width / 2, y + sprite.height, true));
  }
  
  public void render() {
    // set sprite to animation frame here
    image(sprite, x, y);
  }
  
  private boolean checkCollision() {
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile p = projectiles.get(i);
      // check if projectile is in the middle of the enemy
      // TODO: use hitboxes instead of sprite properties,
      //       add collision againt player
      if (p.y > y &&
          p.y < y + sprite.height / 2 &&
          p.x < x + sprite.width &&
          p.x + p.w > x) {
        hitpoints -= p.damage;
        projectiles.remove(i);
        
        if (hitpoints <= 0) {
          score += scoreGain;
          eliminated += 1;
          return true;
        }
      }
    }
    return false;
  }
  private boolean checkPlayerCollision() {
    if (millis() - lastHitTime < 500) { // 500ms kaitseperiood
        return false; // Ära kaota rohkem elusid
    }

    for (int i = projectiles.size() - 1; i >= 0; i--) {
        Projectile p = projectiles.get(i);

        if (p.type.equals("enemy_bullet") &&
            p.y > player.y && p.y < player.y + player.sprite.height &&
            p.x > player.x && p.x < player.x + player.sprite.width) {

            lives -= 1;
            lastHitTime = millis(); // Uuenda viimast tabamuse aega
            p.destroyed = true;

            if (lives <= 0) {
              lives = 0;
              gameOver();
            }

            return true;
        }
    }
    return false;
}

  private boolean checkEntityCollision() {
      for (Entity e : enemies) {
          if (!e.type.equals("player") && 
              player.x < e.x + e.sprite.width && player.x + player.sprite.width > e.x &&
              player.y < e.y + e.sprite.height && player.y + player.sprite.height > e.y) {
              
              lives -= 1;
              lastHitTime = millis(); // Uuenda viimast tabamuse aega
              e.destroyed = true;

              if (lives <= 0) {
                lives = 0;
                gameOver();
              }
              return true;
          }
      }
      return false;
  }
    
  public void gameOver() {
        println("Game Over! Your score: " + score);
        gameState = STATE_GAME_OVER;
    }
}
