class Ball {

  PVector pos;
  PVector vel;
  float bounce = 0.8;
  float r = 5;
  boolean colliding = false;
  int ballNumb = 1;

  Ball(int bn) {
    pos = new PVector(10000,10000);
    vel = new PVector(0,0);
    ballNumb = bn;
  }

  // Main method to operate object
  void update() {
    pos.add(vel);
    vel.mult(0.992);
    borders();
    display();
  }

  // Check for bouncing off borders
  void borders() {
    if (pos.y > height - r) {
      vel.y *= -bounce;
      pos.y = height - r;
    } 
    else if (pos.y < r) {
      vel.y *= -bounce;
      pos.y = r;
    } 
    if (pos.x > width - r) {
      vel.x *= -bounce;
      pos.x = width - r;
    }  
    else if (pos.x < r) {
      vel.x *= -bounce;
      pos.x = r;
    }
  }  

  // Method to display
  void display() {
    ellipseMode(CENTER);
    stroke(0);
    switch(ballNumb){
      case 0:
        fill(255);
        break;
      case 8:
        fill(0);
        break;
      case 1: case 2: case 3: case 4: case 5: case 6: case 7:
        fill(200,0,0);
        break;
      case 9: case 10: case 11: case 12: case 13: case 14: case 15:
        fill(255,255,100);
        break;
    }
    ellipse(pos.x,pos.y,r*2,r*2);
  }

  void collideEqualMass(Ball other) {
    float d = PVector.dist(pos,other.pos);
    float sumR = r + other.r;
    // Are they colliding?
    if (!colliding && d < sumR) {
      // Yes, make new velocities!
      colliding = true;
      // Direction of one object another
      PVector n = PVector.sub(other.pos,pos);
      n.normalize();

      // Difference of velocities so that we think of one object as stationary
      PVector u = PVector.sub(vel,other.vel);

      // Separate out components -- one in direction of normal
      PVector un = componentVector(u,n);
      // Other component
      u.sub(un);
      // These are the new velocities plus the velocity of the object we consider as stastionary
      vel = PVector.add(u,other.vel);
      other.vel = PVector.add(un,other.vel);
    } 
    else if (d > sumR) {
      colliding = false;
    }
  }
}

PVector componentVector (PVector vector, PVector directionVector) {
  //--! ARGUMENTS: vector, directionVector (2D vectors)
  //--! RETURNS: the component vector of vector in the direction directionVector
  //-- normalize directionVector
  directionVector.normalize();
  directionVector.mult(vector.dot(directionVector));
  return directionVector;
}