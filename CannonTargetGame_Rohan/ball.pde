class Ball {

  PVector pos, velocity, acceleration;
  PImage ball;
  PImage[] explosion = new PImage[6];
  int count = 0;
  boolean exploded = false;
  boolean smokeDone = false;
  ArrayList<Smoke> smoke = new ArrayList<Smoke>();
  int smokeSize = 100; //Amount of particles that will be produced per collision


  Ball(PVector velocity_) {
    imageMode(CENTER);
    loadImages();
    pos = new PVector(73, 525);
    velocity = velocity_;
    acceleration = new PVector(0, 0.2);
  }

  void move() {
    if (!exploded && !groundCollision()) {
      pos.add(velocity);
      velocity.add(acceleration);
    } 
  }

  void display() {
    if (!exploded && !groundCollision()) {
      pushMatrix();
      translate(pos.x, pos.y);
      image(ball, 0, 0);
      popMatrix();
    }
  }

  void explosion(ArrayList<Ball> b, int index, Target target) {
    // If there has been a collision or the ball is exploding
    if (index != -1 && (target.targetCollision(b.get(index)) || exploded == true)) {
      exploded = true;
      image(explosion[count], pos.x, pos.y);
      count++;
      if (count > 5) b.remove(index); // remove ball after all frames have been played
    }
  }

  boolean groundCollision() {
    if (pos.y >= 550) {
      return true;
    }
    return false;
  }

  void smoke() {
    if (groundCollision()) {
      if (smokeSize > 0) {
        smoke.add(new Smoke(new PVector(pos.x, pos.y)));
        smokeSize --;
      }
      // See if all smoke paticles have dissappered 
      if (smoke.size() == 0) {
        smokeDone = true;
      }
      for (int i=0; i<smoke.size(); i++) {
        Smoke s = smoke.get(i);
        s.display();
        s.move();
        s.age();
        if (s.dead == true) {
          smoke.remove(i);
          i--;
        }
      }
    }
  }

  void loadImages() {
    ball = loadImage("Cannonball.png");
    for (int i=1; i<7; i++) {
      explosion[i-1] = loadImage("ex" + i + ".png");
    }
  }
}
