class Cell {

  //display related fields
  int size;
  PVector corner; //top left corner
  boolean head;

  //current state and next state
  int state;
  int nextState;
  int x;
  int y;
  
  int timer=0;


  Cell(int _x, int _y, int sz, int st, int sx, int sy) {
    corner = new PVector(_x, _y);
    size = sz;
    state = st;
    x=sx;
    y=sy;
  }

  void display() {
    //set fill color based on state and current color scheme
    if (state == GRASS) {
      fill(colors[colorScheme][1]);
      stroke(0, 200, 0);
    } else if (state == SNAKE) {
      fill(0, 0, 200);
      fill(colors[colorScheme][0]);
    } else if (state==HEAD) {
      fill(0, 0, 150);
      fill(colors[colorScheme][0]);
    }else if (state == APPLE) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
    }
    square(corner.x, corner.y, size);
  }

  //calculate next state

  void updateNextState() { //<>//
    if (gameMode==BASE) {
    int[] headcord=grd.nextHead();
    if (headcord[0]<0||headcord[0]>NUM_ROWS-1||headcord[1]<0||headcord[1]>ROW_LENGTH-1) {
      gameOver = true;
    }
    if (state==SNAKE) {
      if (y==headcord[0]&&x==headcord[1]) {
        gameOver = true;
      }
    }
    if (state==GRASS) {
      if (y==headcord[0]&&x==headcord[1]) {
        nextState=HEAD;
        head=true;
        timer=maxTimer;
      }
    } else if (state==HEAD) {
      head=false;
      nextState=SNAKE;
      timer--;
    } else if (state==APPLE) {
      if (y==headcord[0]&&x==headcord[1]) {
        grd.addTimer();
        nextState=HEAD;
        head=true;
        maxTimer++;
        timer=maxTimer;
      } else {
      nextState=APPLE;
      }
      
    } else if (state==SNAKE) {
      timer--;
      if (timer==0) {
        nextState=GRASS;
      }
    }
    }
  }//updateState

  void changeState() {
    state = nextState;
  }//changeState
}//Cell class
