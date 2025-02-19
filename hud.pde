void drawInterface() {
  textSize(24);
  textAlign(RIGHT);
  text("Score: " + score, width - 10, 24);
  text("Eliminated: " + eliminated + " / " + enemyIndex, width - 10, 48);
  text("Lives: " + player.lives, width - 10, 72);
  //text("Lives: " + 3, width - 10, 72); // placeholder; replace with player's lives
}
