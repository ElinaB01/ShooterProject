class Projectile {
  String type;
  PImage sprite;
  float x, y;
  float speedY;
  int w, h;
  int damage;
  boolean destroyed;
  boolean enemyProjectile;
  
  public Projectile(String type, float x, float y, boolean enemyProjectile) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.enemyProjectile = enemyProjectile;
    
    // TEMPORARY //
      if (type == "bullet") {
        w = 8;
        h = 25;
        sprite = spr_bullet;
        damage = 10;
        speedY = -8.0f;
      } else if (type == "missile") {
        w = 20;
        h = 60;
        sprite = spr_missile;
        damage = 50;
        speedY = -14.0f;
      } else if (type.equals("enemy_bullet")) {
        w = 8;
        h = 25;
        sprite = spr_bullet;
        damage = 10;
        speedY = 8.0f;
      }  
    // TEMPORARY //
  }
  
  public void update() {
    y += speedY;
    destroyed = y < -h || y > height;
    
    image(sprite, x, y);
  }
}
