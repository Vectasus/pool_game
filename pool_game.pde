Ball[] balls = new Ball[16];
Table table = new Table();

float cuePower = 0;

boolean showVectors = false;

void setup() {
  size(400,200);

  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(i);
  }
  
  table = new Table();
  
  table.placeBalls();
  
  
}

void draw() {  
  background(50,150,50);
  
  for (int i = 0; i < balls.length; i++) {
    balls[i].update(); 
  }
  
  for (int b = 0; b < balls.length; b++) {
    for (int a = 0; a < balls.length; a++) {
      if( a - b > 0 ){
        balls[a].collideEqualMass(balls[b]);
      }
    }
  }
}

void mousePressed() {
  PVector n;
  n = new PVector(mouseX,mouseY);
  n.sub(balls[0].pos);
  n.mult(0.05);
  balls[0].vel = n;
}