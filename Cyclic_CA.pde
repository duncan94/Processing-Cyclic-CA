//written on Processing 3.0b3
final int XRES = 256; //Horizontal Resolution
final int YRES = 256; //Vertical Resolution
final int R = 1; //neighbourhood range
final int T = 3; //threshold
final int C = 4; //count of states in the rule
int N = 0; //0 - Moore Neighborhood, 1 - Von Neumann Neighborhood


int[][] cell = new int[XRES][YRES];
int[][] cell_n = new int[XRES][YRES];


int mDistance(int x1, int y1, int x2, int y2) {
  return abs(x2 - x1) + abs(y2 - y1);
}


void calc(int x, int y) {
  int cval = cell[x][y];
  
  int count = 0;
  int val;
  for(int idx = x - R; idx <= x + R; idx++) {
    for(int idx2 = y - R; idx2 <= y + R; idx2++) {
      if(!(idx == x && idx2 == y)) {
      
        if(idx < 0 || idx >= XRES || idx2 < 0 || idx2 >= YRES) {
          val = 0;
        }
        else {
          val = cell[idx][idx2];
        }
        
        if(N == 0) {
          if(val == (cval + 1)%C) {
            count++;
          }
        }
        else if(N == 1) {
          if(mDistance(x, y, idx, idx2) <= R) {
            if(val == (cval + 1)%C) {
              count++;
            }
          }
        }
      }
    }
  }
  
  if(count >= T) {
    cell_n[x][y] = (cval + 1)%C;
  }
  else {
    cell_n[x][y] = cval;
  }
}


void setup() {
  size(512, 512);
  background(0);
  colorMode(HSB, 360, 1, 1);
  frameRate(10);
  
  for(int i = 0; i < XRES; i++) {
    for(int j = 0; j < YRES; j++) {
      cell[i][j] = floor(random(0, C));
    }
  }
}


void draw() {
  background(0);
  
  //Draw and Calc
  for(int i = 0; i < XRES; i++) {
    for(int j = 0; j < YRES; j++) {
      color col = color(cell[i][j]*240.0/floor(C - 1), 1, 1);
      stroke(col);
      fill(col);
      rect(width/XRES * i, height/YRES * j, width/XRES, height/YRES);
      
      calc(i, j);
    }
  }
  
  //Update
  for(int i = 0; i < XRES; i++) {
    for(int j = 0; j < YRES; j++) {
      cell[i][j] = cell_n[i][j];
    }
  }
}