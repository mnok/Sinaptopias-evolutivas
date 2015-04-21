//this part comes from "scalar field polygonisation" by Shane Nelson http://www.openprocessing.org/visuals/?visualID=49742

int gridres =dimX, oldgridres = 0;
float[][][] input;
boolean fill = false;

float slabTreshold=0.2;
int floorDensity=8;

int slabColor=200;

void drawSlice(float[][][] input, int sliceY) {
  stroke(0);
  strokeWeight(2);
  fill(slabColor);
  for (int k=0;k<gridres-1;k++)for (int j=0;j<gridres-1;j++) {
    float a = input[sliceY][j][k], b = input[sliceY][j+1][k], 
    c = input[sliceY][j][k+1], d = input[sliceY][j+1][k+1];

    if (a < slabTreshold && b < slabTreshold && c < slabTreshold && d < slabTreshold && fill) continue;
    float ab = (slabTreshold - a) / (b - a), 
    cd = (slabTreshold - c) / (d - c), 
    ac = (slabTreshold - a) / (c - a), 
    bd = (slabTreshold - b) / (d - b);

    beginShape();
    if (a < slabTreshold) vertex(j, 0, k);
    if (ab > 0 && ab < 1) vertex(j+ab, 0, k);
    if (b < slabTreshold) vertex(j+1, 0, k);
    if (bd > 0 && bd < 1) vertex(j+1, 0, k+bd);
    if (d < slabTreshold) vertex(j+1, 0, k+1);
    if (cd > 0 && cd < 1) vertex(j+cd, 0, k+1);
    if (c < slabTreshold) vertex(j, 0, k+1);
    if (ac > 0 && ac < 1) vertex(j, 0, k+ac);
    endShape(CLOSE);
  }
}

