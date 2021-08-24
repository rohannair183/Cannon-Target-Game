class Smoke {
  PVector pos, velocity;
  int size, lifetime, LIFETIME, countDown;
  boolean dead = false;
  color c = (int(random(100, 170)));


  Smoke(PVector pos_) {
    shapeMode(CENTER);
    pos = new PVector(random(pos_.x - 20, pos_.x + 20), pos_.y);
    velocity = new PVector(random(-0.25, 0.25), -1);
    size = int(random(20, 25));
    lifetime = int(random(110, 160));
    LIFETIME = lifetime; // constant that represents the starting lifetime
    countDown = int(random(0, 40)); // The wait before the particles start moving and aging
  }

  void display() {
    if (countDown == 0) {
      pushMatrix();
      translate(pos.x, pos.y);
      scale(map(lifetime, LIFETIME, 0, 1, 0)); 
      noStroke();
      fill(c);
      circle(0, 0, size);
      popMatrix();
    } else {
      countDown --;
    }
  }

  void move() {    
    if (countDown == 0) {
      pos.add(velocity);
      lifetime --;
    }
  }

  void age() {
    if (lifetime <= 0) {
      dead = true;
    }
  }
}
