void processInputs(int currentTime) {
  if (mouseDown) {
    weaponFire(currentTime);
  }
}

void mousePressed() {
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false;
}