class Game {
  PImage background, backgroundReport, barrel, base;

  // Array of pictures which showcase the number or shots left and targets hit 
  PImage[] cannonBallsLeft = new PImage[21]; 
  PImage[] targetsHit = new PImage[21]; 

  //Contains all instances of shots on the screen
  ArrayList<Ball> shots = new ArrayList<Ball>();

  Target target = new Target();
  float angle = 0;
  float power = 8;

  // To keep track when the game is done
  int shotsLeft = 20;

  // shots may be fired however game is not over until the last shot hits the ground
  boolean gameOver = false;

  Game() {
    imageMode(CENTER);
    loadImages();
  } 

  void play() {
    displayBackground();
    displayStats();
    target.display();
     
     //Checks if either the player is out of shots and no ball is still travelling in the air. 
    if ((outOfShots() && shots.size() == 0) || (outOfShots() && (shots.get(shots.size() - 1).groundCollision() || shots.get(shots.size() - 1).exploded))) {
      gameOver = true;
      reportScreen();
    }

    for (int i=0; i<shots.size(); i++) {
      Ball b = shots.get(i);
      b.move();
      b.display();
      b.smoke();
      if (b.smokeDone) {// Once the smoke animation is done remove the ball
        shots.remove(i);
        i--;
      }
      b.explosion(shots, i, target);
    }

    displayCannon();
  }

  void displayBackground() {
    image(background, width/2, height/2);
  }
  void displayCannon() {
    image(base, 73, 525);
    pushMatrix();
    translate(73, 525);
    rotate(radians(angle)); 
    image(barrel, 0, 0);
    popMatrix();
  }

  void changeAngle(boolean positive) {
    if (positive && angle < 0 && !gameOver) {
      angle += 2;
    } else if (!positive && angle > -90 && !gameOver) {
      angle -= 2;
    }
  }



  void changePower(boolean positive) {
    if (positive && power < 20 && !gameOver) {
      power++;
    } else if (!positive && power > 8 && !gameOver) {
      power--;
    }
  }

  void createShot() {
    if (!outOfShots()) {
      shots.add(new Ball(new PVector(power * cos(radians(angle)), power * sin(radians(angle)))));
      shotsLeft --;
    }
  }

  void displayStats() { 
    fill(0);
    rect(30, 30, power * 23 - 184, 30);
    image(cannonBallsLeft[shotsLeft], 530, 58);
    image(targetsHit[target.targetsHit], 880, 50);
  }

  boolean outOfShots() {
    if (shotsLeft == 0) {
      return true;
    }  
    return false;
  }

  void reportScreen() {
    char rank = ' ';
    String message = "";
    int score = target.targetsHit;
    
    image(backgroundReport, width/2, height/2);
    
    // Creates a message and rank based on user score
    if (score < 2) {
      rank = 'F';
      message = "Better Luck Next Time!";
    } else if (score >= 2 && score < 5) {
      rank = 'D';
      message = "You Can Do Better.";
    } else if (score >= 5 && score < 10) {
      rank = 'C';
      message = "You Did Okay.";
    } else if (score >= 10 && score < 15) {
      rank = 'B';
      message = "You Did Well!";
    } else if (score >= 15) {
      rank = 'A';
      message = "You Did Amazingly!";
    }
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(60);
    text(message, width/2, 140);
    textSize(25);
    text("Your accuracy was " + score + "/20  " + (int((float)score/20*100)) + "%", width/2, 260); 
    text("Rank: " + rank, width/2, 320);
    textSize(15);
    text("Press ENTER to play again", width/2, 380);
  }

  void loadImages() {
    background = loadImage("background.png");
    barrel = loadImage("barrel.png");
    base = loadImage("base.png");
    backgroundReport = loadImage("backgroundReport.png");

    for (int i=0; i<21; i++) {
      cannonBallsLeft[i] = loadImage("shots" + i + ".png");
      targetsHit[i] = loadImage("target" + i + ".png");
    }
  }
}
