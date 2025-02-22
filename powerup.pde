import gifAnimation.*;
import processing.core.PApplet;
ArrayList<PowerUp> powerUps = new ArrayList<>();

class PowerUp {
    float x, y;
    Gif sprite;
    boolean collected;

    public PowerUp(PApplet p, float x, float y) {
        this.x = x;
        this.y = y;
        this.sprite = new Gif(p, "graphics/elu_powerup.gif");
        this.sprite.loop();
        this.collected = false;
    }

    public void update() {
        y += 2;

        if (dist(player.x + player.sprite.width / 2, player.y + player.sprite.height / 2, x, y) < 40) {
            collected = true;
            increasePlayerHealth();
        }
    }

    public void render() {
        if (!collected) {
            image(sprite, x, y);
        }
    }

    private void increasePlayerHealth() {
        if (player.lives < 5) {
            player.lives = min(player.lives + 1, 5);
        }
    }
    public void display(PApplet p) {
    if (!collected) {
      p.image(sprite, x, y);
    }
  }
}
