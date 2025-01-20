ArrayList<Entity> enemies;

Entity player;

class Entity {
  PImage sprite;
  float x, y;
  float speedX, speedY;
  boolean active, destroyed;
  String type;
  
  public Entity(String type, PImage img, float x, float y, float speedX,
                float speedY) {
    this.type = type;
    this.sprite = img;
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  public void update() {
    // TODO:
    // animations
    // inctorduce "hitpoints" variable
    // visual feedback when damage is taken
    // explode on death, damaging nearby planes (player included)
    // have enemies shoot at the player
    
    if (type != "player") {
      y += speedY;
      destroyed = y > height || checkCollision();
    }
  }
  
  public void render() {
    image(sprite, x, y);
  }
  
  private boolean checkCollision() {
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile p = projectiles.get(i);
      // check if projectile is in the middle of the enemy
      // TODO: use hitboxes instead of sprite properties,
      //       add collision againt player
      if (p.y < y + sprite.height / 2 &&
          p.x < x + sprite.width &&
          p.x + p.w > x) {
        projectiles.remove(i);
        return true;
      }
    }
    return false;
  }
}
