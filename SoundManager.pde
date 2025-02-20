import ddf.minim.*;
import processing.core.PApplet;

class SoundManager {
  Minim minim;
  AudioPlayer backgroundMusic;

  SoundManager(PApplet parent) {  // Konstruktor, mis võtab vastu PApplet
    println("Minim alustab...");
    minim = new Minim(parent);  // Kasutab nüüd õiget konteksti
    
    println("Proovin laadida taustamuusikat...");
    backgroundMusic = minim.loadFile("data/sounds/background-music.mp3");

    if (backgroundMusic == null) {
      println("VIGA: Muusikafaili ei leitud!");
    } else {
      println("Muusika laetud, alustame mängimist...");
      backgroundMusic.loop();  // Mängib muusikat loopina
    }
  }

  void stopMusic() {
    backgroundMusic.pause();
    println("Muusika peatatud.");
  }

  void playMusic() {
    backgroundMusic.loop();
    println("Muusika uuesti mängima pandud.");
  }
}
