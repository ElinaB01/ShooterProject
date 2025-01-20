ArrayList<Button> menuButtons;

class Button {
  String label;
  int x, y, w, h;
  boolean selected;
  color buttonColor, textColor;

  public Button(String label, int w, int h) {
    this.label = label;
    this.w = w;
    this.h = h;
  }

  public void click() {
    if (label == "PLAY") {
      menuActive = false;
    }
  }

  public void display(int x, int y, boolean selected) {
    if (selected) {
      buttonColor = buttonHighlight;
      textColor = textHighlight;
      if (mouseDown) click();
    }
    else {
      buttonColor = buttonNormal;
      textColor = textNormal;
    }
    fill(buttonColor);
    rect(x, y, w, h, 15);

    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(32);
    text(label, x + w / 2, y + h / 2);
  }
}
