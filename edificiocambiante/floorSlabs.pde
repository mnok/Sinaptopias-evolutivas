/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/53493*@*
 * SPECULATIVE APPS 001: 'saturation' by echoechonoisenoise
 * Shane Nelson's http://www.openprocessing.org/visuals/?visualID=49742
 * 3d Belousov-Zhabotinsky reaction _ Tommaso Casucci
 * http://www.openprocessing.org/visuals/?visualID=38850
 * expansion of Alasdair Turner code
 * http://www.openprocessing.org/visuals/?visualID=1263
 * echoechonoisenoise 2010
 * echo.link: this-yourWork-this
 * Copyright (C) 2014  Thomas Sanchez Lengeling.
 * KinectPV2, Kinect one library for processing
 * Copyright (C) 2015 Sinaptopias evolutivas  <http://godww7.wix.com/paisajes-evolutivos2/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
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

