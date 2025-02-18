ArrayList<Entity> enemies;

Entity player;

int eliminated = 0;

class Entity {
  String type;
  PImage sprite;
  float x, y;
  float speedX, speedY;
  int hitpoints, scoreGain; // how much score is gained for destroying this enemy
  boolean active, destroyed;
  
  public Entity(String type, int hitpoints, int scoreGain, PImage img, float x, float y, float speedX, float speedY) {
    this.type = type;
    this.hitpoints = hitpoints;
    this.scoreGain = scoreGain;
    this.sprite = img;
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  public void update() {
    // TODO:
    // animations
    // visual feedback when damage is taken
    // explode on death, damaging nearby planes (player included)
    // have enemies shoot at the player
    
    if (type != "player") {
      y += speedY;
      destroyed = y > height || checkCollision();
    }
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
}
