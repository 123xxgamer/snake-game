class Apple {
  int row;
  int col;

  // Constructor
  Apple() {
    placeApple(); 
  }

  void placeApple() {
    do {
      row = int(random(NUM_ROWS));  // Random row
      col = int(random(ROW_LENGTH));  // Random column
    } while (grd.grd[row][col].state != GRASS); // Ensure the cell is empty
    grd.grd[row][col].state = APPLE; // Mark the cell as APPLE
  }

  // Check if the apple is eaten by the snake's head
  boolean isEaten(int headRow, int headCol) {
    return (row == headRow && col == headCol);
  }
}
