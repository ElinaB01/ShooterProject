import java.util.ArrayList;


PFont font;
SoundManager soundManager;

boolean mouseDown, K_UP, K_DOWN, K_LEFT, K_RIGHT;

void debug() {
  fill(240);
  textSize(16);
  text("fps: " + (int)frameRate, 25, 790);
}

ArrayList<Projectile> projectiles = new ArrayList<>();

void setup() {
  size(600, 800);
  noStroke();
  surface.setLocation((displayWidth - width) / 2, (displayHeight - height) / 2);
  
  font = createFont("gunplay-rg.otf", 16);
  textFont(font);
  
  loadGraphics();
  initGame();
  
  menuSetup();
  
  soundManager = new SoundManager(this);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    soundManager.stopMusic();  // Vajutades S peatab muusika
  }
  if (key == 'p' || key == 'P') {
    soundManager.playMusic();  // Vajutades P mängib uuesti
  }
}

void draw() {
  background(0);
  
  if (menuActive) {
    drawMainMenu();
  } else {
    updateGame();
    drawInterface();
  }
  
  // TEMPORARY
  debug();
}
