int menuX, menuY, menuW, menuH;
int buttonSpacing = 25;

color buttonNormal, buttonHighlight, textNormal, textHighlight;

boolean menuActive = true;

// TODO: Move this section to a game state: STATE_VIEW_MENU

void menuSetup() {
  menuButtons.add(new Button("PLAY", 300, 75));
  menuButtons.add(new Button("SHOP", 270, 67));
  menuButtons.add(new Button("TUTORIAL", 245, 60));
  menuButtons.add(new Button("SETTINGS", 220, 55));
  menuButtons.add(new Button("SCORES", 195, 50));
  
  buttonNormal = color(35, 70, 90);
  buttonHighlight = color(55, 110, 140);
  textNormal = color(190, 150, 130);
  textHighlight = color(255);
  
  menuW = 400; // button container dimensions
  menuH = 480;
  menuX = width / 2 - menuW / 2; // position: center of the screen
  menuY = height / 2 - menuH / 2;
}

void drawMainMenu() {
  // temporary! background, dark tint
  image(img_bg, 0, offset);
  image(img_bg, 0, offset - img_bg.height);
  image(img_bg, 0, offset + img_bg.height);
  fill(0, 80);
  rect(0, 0, width, height);
  // TODO: filter(BLUR, 5) cannot be used yet (too slow in real-time rendering)
  
  // button container
  fill(90, 80, 35, 230);
  rect(menuX, menuY, menuW, menuH, 20);
  
  int yPos = menuY + 40;

  for (Button button : menuButtons) {
    button.x = width / 2 - button.w / 2;
    button.y = yPos;
    
    boolean selected = mouseX > button.x && mouseX < button.x + button.w &&
                       mouseY > button.y && mouseY < button.y + button.h;

    button.display(button.x, button.y, selected);
    yPos += button.h + buttonSpacing;
  }
}
