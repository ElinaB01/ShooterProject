PImage img_bg;
PImage spr_player, spr_enemy1, spr_projectile1, spr_explosion;

int level;
// Kas see jääb alles?
void initGame() {
  enemies = new ArrayList<>();
  projectiles = new ArrayList<>();
  menuButtons = new ArrayList<>();
  player = new Entity(
      "player",                         /* identification type */
      spr_player,                       /* starting sprite */
      width / 2 - spr_player.width / 2, /* horizontal position (center) */
      height + spr_player.height * 2,   /* vertical (below the screen) */
      0, 0                              /* horizontal and vertical speed */
  );
  
  level = 1;
  loadLevel("levels/level" + level + ".txt");
  gameState = STATE_ENTERING_LEVEL;
  
  yTarget = height - 170;
}

void loadLevel(String path) {
  String[] lines = loadStrings(path);
  
  for (String line : lines) {
    if (line.startsWith("#") || line.isEmpty()) {
      continue;
    }
    line = line.replaceAll("\\s+", ""); // remove all spaces
    String[] parts = split(line, ",");
    
    String enemyType = parts[0];
    int amount = int(parts[1]);
    
    for (int i = 0; i < amount; i++) {
      enemies.add(new Entity(enemyType, spr_enemy1, 0, 0, 0, 0));
    }
  }
  lastSpawn = 0;
  enemyIndex = 0;
}

void loadGraphics() {
  img_bg = loadImage("graphics/bg.png");
  img_bg.resize(600, 400);
  
  spr_player = loadImage("graphics/player.png");
  spr_enemy1 = loadImage("graphics/enemy1.png");
  spr_projectile1 = loadImage("graphics/projectile1.png");
  spr_explosion = loadImage("graphics/explosion.png");
  
  spr_player.resize(80, 115);
  spr_enemy1.resize(80, 115);
}
