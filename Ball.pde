float FRICTION = 0.02;

class Trajectory{
  PVector p;
  PVector v;
  float t;
  Trajectory(PVector startPosition, PVector startVelocity, float startTime){
    p = startPosition;
    v = startVelocity;
    t = startTime;
  }
  Trajectory getPosAtTime( float pt ){ //passedTime
    PVector np = new PVector(), nv = new PVector();
    
    np.add(nv);
    Trajectory newTraj = new Trajectory( np ,nv, pt + t );
    return newTraj;
  }
  
  void display(){
    line( p.x, p.y, p.x + v.x, p.y + v.y );
  }
}

class Ball{

  PVector pos;
  PVector vel;
  float bounce = 0.8;
  float r = 5;
  boolean colliding = false;
  int ballNumb = 1;
  float friction = 0.02;
  Trajectory[] traj = new Trajectory[1];
  boolean inField;

  Ball( int bn ){
    inField = false;
    pos = new PVector( 100, 100 );
    vel = new PVector( 0, 0 );
    ballNumb = bn;
  }

  // Main method to operate object
  void update(){
    vel.mult( 1- friction );
    if( vel.mag() < 0.05 ){
      vel.set( 0, 0 );
    }
    pos.add( vel );
  }

  // Method to display
  void display(){
    ellipseMode( CENTER );
    stroke( 0 );
    switch( ballNumb ){
      case 0:
        fill( 255 );
        break;
      case 8:
        fill( 0 );
        break;
      case 1: case 2: case 3: case 4: case 5: case 6: case 7:
        fill( 200, 0, 0 );
        break;
      case 9: case 10: case 11: case 12: case 13: case 14: case 15:
        fill( 255, 255, 100 );
        break;
    }
    ellipse( pos.x, pos.y, r*2, r*2 );
  }
  
  void bounce( PVector dir ){
    //rotate reference frame
    //calculate impulse on x
    
    //rotate reference frame back
  }

  void collideEqualMass( Ball other ){
    float d = PVector.dist( pos, other.pos );
    float sumR = r + other.r;
    // Are they colliding?
    if( !colliding && d < sumR ){
      // Yes, make new velocities!
      colliding = true;
      // Direction of one object another
      PVector n = PVector.sub( other.pos, pos );

      // Difference of velocities so that we think of one object as stationary
      PVector u = PVector.sub( vel, other.vel );

      // Separate out components -- one in direction of normal
      PVector un = componentVector( u, n );
      // Other component
      u.sub( un );
      // These are the new velocities plus the velocity of the object we consider as stastionary
      vel = PVector.add( u, other.vel );
      other.vel = PVector.add( un, other.vel );
    } 
    else if( d > sumR ){
      colliding = false;
    }
  }
}

PVector componentVector( PVector vector, PVector directionVector ){
  //--! ARGUMENTS: vector, directionVector( 2D vectors )
  //--! RETURNS: the component vector of vector in the direction directionVector
  //-- normalize directionVector
  directionVector.normalize();
  directionVector.mult( vector.dot( directionVector ) );
  return directionVector;
}