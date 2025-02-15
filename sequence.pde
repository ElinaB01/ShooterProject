final int STATE_ENTERING_LEVEL = 0;
final int STATE_LEVEL_READY = 1;
final int STATE_PLAYING = 2;

int gameState;

float yTarget;
int levelStartTime;

void enterLevel() {
  if (player.y > yTarget) {
    player.y = lerp(player.y, yTarget, 0.05);
    if (abs(player.y - yTarget) < 1) {
      player.y = yTarget;
    }
  } else {
    displayLevelInfo();
  }
}

void displayLevelInfo() {
  // TODO: animate the texts in and out
  fill(255); //to make text white, once the font is added
  textAlign(CENTER, CENTER);
  textSize(64);
  text("LEVEL " + level, width / 2, 230);
  textSize(26);
  text("Click on the screen to start", width / 2, 290);

  if (mousePressed) {
    gameState = STATE_PLAYING;
    player.active = true;
    
    // BUG: one bullet gets fired here
  }
}
