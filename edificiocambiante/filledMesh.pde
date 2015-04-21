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

//this is part of toxi's "box fluid demo" modified for purposes of extracting vertex colors from volumetric color data

void drawFilledMesh() {
  noStroke();
  int num=mesh.getNumFaces();
  mesh.computeVertexNormals();
  beginShape(TRIANGLES);
  for (int i=0; i<num; i++) {
    Face f=mesh.faces.get(i);
    fill(colors[(int)map(f.a.x, -scs/2, scs/2, 0, dimX)][(int)map(f.a.y, -scs, scs, 0, dimY)][(int)map(f.a.z, -scs/2, scs/2, 0, dimZ)]);
    normal(f.a.normal);
    vertex(f.a);
    fill(colors[(int)map(f.b.x, -scs/2, scs/2, 0, dimX)][(int)map(f.b.y, -scs, scs, 0, dimY)][(int)map(f.b.z, -scs/2, scs/2, 0, dimZ)]);
    normal(f.b.normal);
    vertex(f.b);
    fill(colors[(int)map(f.c.x, -scs/2, scs/2, 0, dimX)][(int)map(f.c.y, -scs, scs, 0, dimY)][(int)map(f.c.z, -scs/2, scs/2, 0, dimZ)]);
    normal(f.c.normal);
    vertex(f.c);
  }
  endShape();
}


void normal(Vec3D v) {
  normal(v.x, v.y, v.z);
}

void vertex(Vec3D v) {
  vertex(v.x, v.y, v.z);
}

void vertex(Vec3D v, float _u, float _v) {
  vertex(v.x, v.y, v.z, _u, _v);
}

