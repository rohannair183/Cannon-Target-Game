class Target {
  PImage target;
  PVector pos;
  int targetsHit = 0;

  Target() {
    imageMode(CENTER);
    target = loadImage("target.png");
    pos = new PVector(random(190, width - target.width), random(120 + target.height, 480 - target.height));
  }

  void display() {
    image(target, pos.x, pos.y);
  }

  void changePosition() {
    pos = new PVector(random(100, width - target.width), random(100, 525 -target.height));
    targetsHit++;
  }


  boolean targetCollision(Ball shot) {
    // Accesing the PImage within the Ball class and getting its width divided by two for its radius
    int ballRadius = shot.ball.width/2; 
    int targetRadius = target.width/2;
    
    // Change position and return true if there is a collision
    if (dist(shot.pos.x, shot.pos.y, pos.x, pos.y) < ballRadius + targetRadius) {
      changePosition();
      return true;
    }
    return false;
  }
}
