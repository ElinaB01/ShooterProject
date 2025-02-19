import java.util.ArrayList;

PFont font;

boolean mouseDown, K_UP, K_DOWN, K_LEFT, K_RIGHT;

void debug() {
  fill(240);
  textSize(16);
  text("fps: " + (int)frameRate, 25, 790);
}

void setup() {
  size(600, 800);
  noStroke();
  surface.setLocation((displayWidth - width) / 2, (displayHeight - height) / 2);
  
  font = createFont("gunplay-rg.otf", 16);
  textFont(font);
  
  loadGraphics();
  initGame();
  
  menuSetup();
}

void draw() {
  background(0);
  
  if (menuActive) {
    drawMainMenu();
  } else {
    updateGame();
  }
  // TEMPORARY
  debug();
}

void drawScore() {
  fill(255);
  textSize(32);
  textAlign(RIGHT, TOP);
  text("Score: " + score, width - 20, 20);
}
