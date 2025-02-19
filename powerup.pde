ArrayList<PowerUp> powerUps = new ArrayList<>();

class PowerUp {
    float x, y;
    PImage sprite;
    boolean collected;

    public PowerUp(float x, float y) {
        this.x = x;
        this.y = y;
        this.sprite = loadImage("graphics/powerup.png");
        this.sprite.resize(30, 30);
        this.collected = false;
    }

    public void update() {
        y += 2;

        if (dist(player.x + player.sprite.width / 2, player.y + player.sprite.height / 2, x, y) < 30) {
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
        if (player.hitpoints < 100) {
            player.hitpoints = min(player.hitpoints + 20, 100);
        }
    }
}