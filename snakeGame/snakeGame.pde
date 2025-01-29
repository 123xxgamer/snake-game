//State variables
int GRASS=0;
int SNAKE=1;
int HEAD=2;
int APPLE=3;

//color variables
color[][] colors={{#000000, #FFFFFF, color(150, 255, 180)}, {color(50, 70, 10), color(170, 150, 180), color(240, 250, 180)}, {color(70, 10, 50), color(150, 180, 110), color(180, 240, 250)}, {color(100, 10, 10), color(100, 255, 150), color(250, 200, 250)}, {color(10, 10, 100), color(255, 50, 50), color(210, 225, 255)}}; //array of color schemes; each sub array is ALIVECOLOR, DEADCOLOR, INFOAREACOLOR
int colorScheme=0;

//setup variables
int NUM_ROWS = 16;
int ROW_LENGTH = 16;

//gamemode variables and gameplay variables
int curDir;//current direction
int BASE=0;
int numModes=0;

// other driver variables
boolean play;
int gameMode;
int maxSpeed = 3;
Grid grd;
Apple apple; // Add the Apple object
int sz;
int speed;
int infoHeight = 155;
boolean gameOver;
int maxTimer = 4;


void settings() {
  int gWidth=((displayHeight-infoHeight-250+ROW_LENGTH/2)/ROW_LENGTH)*ROW_LENGTH;
  size(gWidth, gWidth+infoHeight);
}

void setup() {
  frameRate(60);
  speed=2;
  background(colors[colorScheme][2]);
  textAlign(CENTER, CENTER);
  play = false;
  gameOver=false;
  curDir=RIGHT;
  gameMode=BASE;


  grd = new Grid(NUM_ROWS, ROW_LENGTH);
  apple = new Apple(); // Create the Apple object


  sz=grd.sz;

  grd.grd[7][5].head=true;
  grd.grd[7][5].state=HEAD;
  grd.grd[7][5].timer=4;
  grd.grd[7][4].state=SNAKE;
  grd.grd[7][4].timer=3;
  grd.grd[7][3].state=SNAKE;
  grd.grd[7][3].timer=2;
  grd.grd[7][2].state=SNAKE;
  grd.grd[7][2].timer=1;
  grd.grd[7][12].state=APPLE;
  grd.grd[7][12].timer=1;
}//setup

void draw() {
  runGame();
  displayInfo();
}//draw

void keyPressed() {
  if (key==' ') {
    play=!play;
  }
  if (key=='r') {
    play=false;
    grd = new Grid(NUM_ROWS, ROW_LENGTH);
    gameOver=false;
    curDir=RIGHT;
  grd.grd[7][5].head=true;
  grd.grd[7][5].state=HEAD;
  grd.grd[7][5].timer=4;
  grd.grd[7][4].state=SNAKE;
  grd.grd[7][4].timer=3;
  grd.grd[7][3].state=SNAKE;
  grd.grd[7][3].timer=2;
  grd.grd[7][2].state=SNAKE;
  grd.grd[7][2].timer=1;
  grd.grd[7][12].state=APPLE;
  grd.grd[7][12].timer=1;
  }
  if (keyCode==UP) {
    if (play && curDir != DOWN) {
      curDir=UP;
    }
  }
  if (keyCode==DOWN) {
    if (play && curDir != UP) {
      curDir=DOWN;
    }
  }
  if (keyCode==RIGHT) {
    if (play && curDir != LEFT) {
      curDir=RIGHT;
    }
  }
  if (keyCode==LEFT) {
    if (play && curDir != RIGHT) {
      curDir=LEFT;
    }
  }
  if (key=='c') {
    if (colorScheme<colors.length-1) {
      colorScheme++;
    }
  }
  if (key=='z') {
    if (colorScheme>0) {
      colorScheme--;
    }
  }
  //if (play != true) {
    if (key=='d') {
      if (gameMode<numModes) {
        gameMode++;
      }
    }
    if (key=='a') {
      if (gameMode>0) {
        gameMode--;
      }
    }
    if (key=='e') {
      if (speed<maxSpeed) {
        speed++;
      }
    }
    if (key=='q') {
      if (speed>1) {
        speed--;
      }
    }
  //}
}//keyPressed

String mode(int mode) {
  if (mode==BASE) {
    return "Base Snake";
  }
  return "PROGRAM ERROR: RESTART SIMULATION";//this line should never be reached, but the function needs a backup return statement in case none of the if statements can be reached
}
void runGame() {
  if (gameOver) {
    noStroke();
    textSize(50);
    textAlign(CENTER);
    text("Game Over", width/2, (height+infoHeight)/2);
    textSize(20);
    text("Press 'r' to restart", width/2, (height+infoHeight)/2+30);
  }
  else {
    if (frameCount%(5*(4-speed))==0) {
      grd.displayAll();
      if (play) {
        int[] headCord = grd.nextHead(); // Get the next head position
        if (apple.isEaten(headCord[0], headCord[1])) {
          maxTimer++; // Grow the snake
          apple.placeApple(); // Place a new apple
        }
        grd.playSim();
      }
    }
  }
}
void displayInfo() {
  fill(colors[colorScheme][2]);
  stroke(colors[colorScheme][2]);
  rect(0, 0, width, infoHeight);
  fill(0);
  textSize(infoHeight/6);
  textAlign(LEFT, CENTER);
  text("Game mode: "+mode(gameMode)+"\nSpeed: "+speed, width/24, infoHeight/2); // display current game mode and speed
  textSize(infoHeight/10);
  //textAlign(CENTER,CENTER);
  text("Controls:\narrow keys to control snake\na/d arrow to switch game mode\nspace to pause/unpause\nr to reset;\nq/e to change speed\nz/c to change color scheme", width/2, infoHeight/2);
}
