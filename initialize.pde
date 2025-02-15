PImage img_bg;
PImage spr_player, spr_fighter, spr_bullet, spr_missile, spr_explosion;

int level;

void initGame() {
  enemies = new ArrayList<>();
  projectiles = new ArrayList<>();
  menuButtons = new ArrayList<>();
  player = new Entity(
      "player",                         /* identification type */
      100,                              /* hitpoints */
      0,                                /* score per kill (not applicable to player) */
      spr_player,                       /* starting sprite */
      width / 2 - spr_player.width / 2, /* horizontal position (center) */
      height + spr_player.height * 2,   /* vertical pos (below the screen) */
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
    int hitpoints = int(parts[1]);
    int scoreGain = int(parts[2]);
    int amount = int(parts[3]);
    
    for (int i = 0; i < amount; i++) {
      enemies.add(new Entity(enemyType, hitpoints, scoreGain, spr_fighter, 0, 0, 0, 0));
    }
  }
  lastSpawn = 0;
  enemyIndex = 0;
}

void loadGraphics() {
  img_bg = loadImage("graphics/bg.png");
  img_bg.resize(600, 400);
  
  spr_player = loadImage("graphics/player.png");
  spr_fighter = loadImage("graphics/fighter.png");
  spr_bullet = loadImage("graphics/rocket.png"); // TODO: add custom graphic
  spr_missile = loadImage("graphics/rocket.png");
  spr_explosion = loadImage("graphics/explosion.png");
  
  spr_player.resize(90, 125);
  spr_fighter.resize(75, 110);
  spr_bullet.resize(8, 25);
  spr_missile.resize(20, 60);
}
