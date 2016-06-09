Ball[] balls = new Ball[16];
Table table = new Table();

float cuePower = 0;

boolean showVectors = false;

void setup(){
  fullScreen();
  for( int i = 0; i < balls.length; i++ ){
    balls[i] = new Ball( i );
  }
  
  table = new Table();
  
  table.placeBalls();
}

void draw(){  
  
  //draw
  background( 50, 150, 50 );
  
  table.display();
  
  for( int i = 0; i < balls.length; i++ ){
    if( balls[i].inField ){
      balls[i].update();
      balls[i].display();
    }
  }
  
  //logic
  
  for( int b = 0; b < balls.length; b++ ){
    for( int p = 0; p < table.pockets.length; p++ ){
      PVector diff = new PVector( balls[b].pos.x, balls[b].pos.y );
      diff.sub( table.pockets[p] );
      if( balls[b].inField && ( diff.mag() < table.pr ) ){
        balls[b].inField = false;
      }
    }
  }
  
  for( int b = 0; b < balls.length; b++ ){
    for( int a = 0; a < balls.length; a++ ){
      if( a - b > 0 && ( balls[a].inField && balls[b].inField ) ){
        balls[a].collideEqualMass( balls[b] );
      }
    }
  }
}

void mousePressed(){
  PVector n;
  n = new PVector( mouseX, mouseY );
  n.sub( balls[0].pos );
  n.mult( 0.05 );
  balls[0].vel = n;
}