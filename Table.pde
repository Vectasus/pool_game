
class Table{
  
  PVector fieldOrigin = new PVector( 0, 0 );
  PVector fieldSize = new PVector( width, height );
  
  PVector fieldDiv( float xDiv, float yDiv ){
    PVector pos = new PVector( fieldSize.x * xDiv, fieldSize.y * yDiv );
    return pos;
  }
  
  void placeBalls(){
    boolean[] ballsUsed = new boolean[16];
    
    float r = balls[1].r * 2;
    
    balls[0].pos = fieldDiv( .25, .5 );
    ballsUsed[0] = true;
    ballsUsed[8] = true; //reserved
    
    PVector c = fieldDiv( .75, .5 );
    for (int col = 0; col <= 4; col++ ) {
      for (int row = 0; row <= 4; row++ ) {
        if( col - row >= 0){
          int p = floor( random( 1, 16 ) );
          while( ballsUsed[p] == true ){
            p = floor( random( 1, 16 ) );
          }
          if ( col == 2 && row == 1 ) p = 8;
          float colFloat = col;
          PVector offset = new PVector( col,  row - colFloat / 2 );//
          offset.mult( r );
          offset.add( c );
          balls[p].pos = offset;
          ballsUsed[p] = true;
        } 
      }
    }
  }
}