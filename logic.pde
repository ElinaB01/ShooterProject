void updateGame() {
  int currentTime = millis();
  
  switch (gameState) {
    case STATE_ENTERING_LEVEL:
      scrollBackground();
      updatePlayer();
      enterLevel();
      break;
  
    case STATE_PLAYING:
      processInputs(currentTime);
      
      scrollBackground();
      spawnEnemy(currentTime);
      
      updateEntities();
      updatePlayer();
      updateProjectiles();
      
      // TODO:
      // add menu button in top-left corner
      // add score and lives in the top-right corner
      break;

    // TODO:
    // STATE_VIEW_MENU
    // STATE_VIEW_SHOP
    // STATE_VIEW_SETTINGS
    // STATE_LEVEL_COMPLETED
    // STATE_GAME_OVER
  }
}

void levelComplete() {
  level++;
  enemies.clear();
  
  // TODO: proceed to the next level
}

float followSpeed = 0.14f;

void updatePlayer() {
  if (player.active) {
    player.x = lerp(player.x, mouseX - player.sprite.width / 2, followSpeed);
    player.y = lerp(player.y, mouseY - player.sprite.height / 2, followSpeed);
    
    player.update();
  }
  player.render();
}

void updateEntities() {
  for (int i = 0; i < enemies.size(); i++) {
    Entity enemy = enemies.get(i);
    // ignore enemies that are dead or have not spawned in yet
    if (enemy.destroyed || !enemy.active) continue;
    enemy.update();
    enemy.render();
  }
}

int fireRate = 240;
int lastFire = 0;

void weaponFire(int currentTime) {
  if (currentTime - lastFire >= fireRate) {
    projectiles.add(new Projectile(spr_projectile1, player.x + player.sprite.width / 2, player.y));
    lastFire = currentTime;
  }
}

void updateProjectiles() {
  for (int i = 0; i < projectiles.size(); i++) {
    projectiles.get(i).update();
    if (projectiles.get(i).destroyed) {
      projectiles.remove(i);
    }
  }
}

int lastSpawn, spawnInterval, enemyIndex;

void spawnEnemy(int currentTime) {
  if (currentTime - lastSpawn >= spawnInterval) {
    lastSpawn = currentTime;
    spawnInterval = (int)random(500, 3000); // milliseconds between spawns
    if (enemyIndex < enemies.size()) {
      Entity enemy = enemies.get(enemyIndex);
      enemy.active = true;
      enemy.x = random(0, width - enemy.sprite.width);
      enemy.y = -enemy.sprite.height;
      enemy.speedX = 0; // initialize for diagonal movement
      enemy.speedY = random(2.0f, 6.0f);
      
      println("Spawn index " + enemyIndex); // debug
      enemyIndex++;
    } else {
      levelComplete();
      println("No more enemies left to spawn!"); // debug
    }
  }
}

int offset = 0, scrollSpeed = 2;

void scrollBackground() {
  // draw three background images stacked vertically
  image(img_bg, 0, offset);
  image(img_bg, 0, offset - img_bg.height);
  image(img_bg, 0, offset + img_bg.height);

  offset += scrollSpeed;

  if (offset > img_bg.height) {
    offset = 0;
  }
}
