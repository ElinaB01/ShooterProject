import java.util.ArrayList;

PFont font;

boolean mouseDown, K_UP, K_DOWN, K_LEFT, K_RIGHT;

void debug() {
  fill(0);
  textSize(32);
  text((int)frameRate, 20, 20); // FPS counter
}

void setup() {
  size(600, 800);
  noStroke();
  surface.setLocation((displayWidth - width) / 2,
                      (displayHeight - height) / 2);
  
  //font = createFont("replace-with-font-name.ttf", 128);
  //textFont(font);
  
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
