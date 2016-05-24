Mover[] movers = new Mover[16];

float cuePower = 0;

boolean showVectors = false;

void setup() {
  size(400,200);

  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(new PVector(10,10),i); 
  }
}

void draw() {  
  background(100,200,100);
  
  for (int i = 0; i < movers.length; i++) {
    movers[i].go(); 
  }
  
  for (int b = 0; b < movers.length; b++) {
    for (int a = 0; a < movers.length; a++) {
      if( a - b > 0 ){
        movers[a].collideEqualMass(movers[b]);
      }
    }
  }
}

void mousePressed() {
  PVector n;
  n = new PVector(mouseX,mouseY);
  n.sub(movers[0].loc);
  n.mult(0.05);
  movers[0].vel = n;
}