int score;

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
      updateProjectiles();
      updatePlayer();
      
      drawInterface();

      for (int i = powerUps.size() - 1; i >= 0; i--) {
        powerUps.get(i).update();
        powerUps.get(i).render();

        if (powerUps.get(i).collected) {
          powerUps.remove(i);
        }
      }
      
      // TODO:
      // add menu button in top-left corner
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
  // loadLevel("levels/level" + level + ".txt");
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
  for (int i = enemies.size() - 1; i >= 0; i--) {  // Kordamööda tagurpidi
    Entity enemy = enemies.get(i);

    if (enemy.destroyed) {  
      enemies.remove(i); // Kustutab hävinenud vaenlased
      continue;  // Hüppa järgmise tsükli juurde, et vältida update/renderi käivitamist
    }

    if (!enemy.active) continue; // Ignoreeri veel aktiivseks muutmata vaenlasi
    
    enemy.update();
    enemy.render();
  }
}

int fireRate = 240;
int lastFire = 0;
int missileCooldownMax = 100;
int missileCooldown = missileCooldownMax;

void weaponFire(int currentTime) {
  if (mouseButton == LEFT) {
    if (currentTime - lastFire >= fireRate) {
      float x_center = player.x + player.sprite.width / 2 - 4;
      projectiles.add(new Projectile("bullet", x_center, player.y, false));
      lastFire = currentTime;
    }
  } else if (mouseButton == RIGHT) {
    // TODO:
    // player has limited amount of missiles (can buy more at the shop)
    // creates blast damage on impact
    // accelerates as it moves?
    if (missileCooldown > missileCooldownMax) {
      float x_center = player.x + player.sprite.width / 2 - 10;
      projectiles.add(new Projectile("missile", x_center, player.y, false));
      missileCooldown = 0;
    }
  }
  missileCooldown++;
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
      
      println("Spawn #" + enemyIndex + ":", enemy.type); // debug
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
