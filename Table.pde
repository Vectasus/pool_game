
class Table{
  
  PVector fieldOrigin = new PVector( 20, 20 );
  PVector fieldSize = new PVector( width -40, height -40);
  
  PVector fieldDiv( float xDiv, float yDiv ){
    PVector pos = new PVector( fieldOrigin.x + fieldSize.x * xDiv, fieldOrigin.y + fieldSize.y * yDiv );
    return pos;
  }
  
  PVector[] pockets = new PVector[6];
  float pr = 10;
  
  Table(){
    pockets[0] = fieldDiv(0,0);
    pockets[1] = fieldDiv(.5,0);
    pockets[2] = fieldDiv(1,0);
    pockets[3] = fieldDiv(0,1);
    pockets[4] = fieldDiv(.5,1);
    pockets[5] = fieldDiv(1,1);
  }
  
  void placeBalls(){
    
    float r = balls[1].r * 2;
    
    balls[0].pos = fieldDiv( .25, .5 );
    balls[0].inField = true;
    balls[8].inField = true; //reserved
    
    PVector c = fieldDiv( .75, .5 );
    for (int col = 0; col <= 4; col++ ) {
      for (int row = 0; row <= 4; row++ ) {
        if( col - row >= 0){
          int p = floor( random( 1, 16 ) );
          while( balls[p].inField == true ){
            p = floor( random( 1, 16 ) );
          }
          if ( col == 2 && row == 1 ) p = 8;
          float colFloat = col;
          PVector offset = new PVector( col,  row - colFloat / 2 );//
          offset.mult( r );
          offset.add( c );
          balls[p].pos = offset;
          balls[p].inField = true;
        } 
      }
    }
  }
  
  void display(){
    ellipseMode(CENTER);
    stroke(0);
    fill(1);
    for( int i = 0; i < pockets.length; i++ ){
      ellipse(pockets[i].x,pockets[i].y,pr*2,pr*2);
    }
  }
}