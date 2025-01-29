class Grid {

  Cell[][] grd;
  int sz; //size

  Grid (int numRows, int numCols) {
    grd= new Cell[numRows][numCols];
    sz=width/numCols;
    createGrid();
  }//constructor

  void createGrid () {
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
          grd[r][c]=new Cell(sz*c, sz*r+infoHeight, sz, GRASS, c, r);
      }
    }
  }// instantiate grd with Cells

  void displayAll () {
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
        grd[r][c].display();
      }
    }
  }// display() all Cells in grd

  int[] nextHead() {
    int[] nhead=new int[2];
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
        if(grd[r][c].state==HEAD) {
          
          if (curDir==UP) {
            nhead[0]=r-1;
            nhead[1]=c;
          }
          if (curDir==DOWN) {
            nhead[0]=r+1;
            nhead[1]=c;
          }
          if (curDir==LEFT) {
            nhead[0]=r;
            nhead[1]=c-1;
          }
          if (curDir==RIGHT) {
            nhead[0]=r;
            nhead[1]=c+1;
          }
          
    return nhead;
        }
      }
    }
    return nhead;
  }// 
  void playSim() {
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
        grd[r][c].updateNextState();
      }
    }
    updateStates();
  }// update next state for all with Life logic, then update state
  void addTimer() {
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
        if (grd[r][c].state==SNAKE) {
        grd[r][c].timer++;
        }
      }
    }
  }
  void updateStates() {
    for (int r=0; r<grd.length; r++) {
      for (int c=0; c<grd[r].length; c++) {
        grd[r][c].changeState();
      }
    }
  }// update state from next state
}//class Grid
