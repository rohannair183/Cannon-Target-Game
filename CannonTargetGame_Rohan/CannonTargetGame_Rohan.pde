// Cannon Target Game
// CS 30
// Rohan Nair
// The user controls a cannon that can fire 20 shots and have to hit as many targets as possible

Game currentGame;

void setup() {
  size(1068, 600);
  currentGame  = new Game();
}

void draw() {
  currentGame.play();
  input(); // For smoother movement of the cannon
}

void keyPressed() {
  if (key == ' ') {
    currentGame.createShot();
  }
  if (keyCode == UP) {
    currentGame.changePower(true);
  } else  if (keyCode == DOWN) {
    currentGame.changePower(false);
  }

  if (keyCode == ENTER) {
    if (currentGame.gameOver) {
      currentGame = new Game();
    }
  }
}

void input() {
  if (keyPressed) {
    if (keyCode == LEFT) {
      currentGame.changeAngle(false);
    } else if (keyCode == RIGHT) {
      currentGame.changeAngle(true);
    }
  }
}
