PImage img_bg;
PImage spr_player, spr_fighter, spr_bullet, spr_missile, spr_explosion;
PImage[] playerFrames; // Array to store player animation frames
int level;

void initGame() {
  enemies = new ArrayList<>();
  projectiles = new ArrayList<>();
  menuButtons = new ArrayList<>();
  PImage defaultPlayerFrame = playerFrames[19];
  player = new Entity(
      this,                             // Pass the PApplet instance
      "player",                         /* identification type */
      100,                              /* hitpoints */
      0,                                /* score per kill (not applicable to player) */
      defaultPlayerFrame,                       /* starting sprite */
      width / 2 - defaultPlayerFrame.width / 2, /* horizontal position (center) */
      height + defaultPlayerFrame.height * 2,   /* vertical pos (below the screen) */
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
      enemies.add(new Entity(this, enemyType, hitpoints, scoreGain, spr_fighter, 0, 0, 0, 0));
    }
  }
  lastSpawn = 0;
  enemyIndex = 0;
}

void loadGraphics() {
  img_bg = loadImage("graphics/bg.png");
  img_bg.resize(600, 400);
  spr_fighter = loadImage("graphics/fighter.png");
  spr_bullet = loadImage("graphics/rocket.png"); // TODO: add custom graphic
  spr_missile = loadImage("graphics/rocket.png");
  spr_explosion = loadImage("graphics/explosion.png");
  
  spr_fighter.resize(75, 110);
  spr_bullet.resize(8, 25);
  spr_missile.resize(20, 60);
  
  // Load the player spritesheet
  PImage spritesheet = loadImage("graphics/player_spritesheet.png");
  playerFrames = new PImage[39]; // 39 frames in the spritesheet
  int frameWidth = 430; // Width of each frame
  int frameHeight = 430; // Height of each frame

  // Split the spritesheet into individual frames
  for (int i = 0; i < 39; i++) {
    playerFrames[i] = spritesheet.get(i * frameWidth, 0, frameWidth, frameHeight);
    playerFrames[i].resize(90, 125); // Resize to match your player size
  }
  
}
