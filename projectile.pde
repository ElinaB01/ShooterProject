ArrayList<Projectile> projectiles;

class Projectile {
  PImage sprite;
  float x, y;
  float speedY;
  int w, h;
  boolean destroyed;
  
  public Projectile(PImage img, float x, float y) {
    this.sprite = img;
    this.x = x;
    this.y = y;
    
    // DEBUG //
    w = 4;
    h = 16;
    speedY = -8.0f;
  }
  
  public void update() {
    y += speedY;
    destroyed = y < 0 || y > height;
    
    image(sprite, x, y);
  }
}
