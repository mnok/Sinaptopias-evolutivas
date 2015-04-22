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

class TriangularPanel {
  PVector p1,p2,p3;//three input points
  PVector[] q_pts;//array of quarter parts of all the edges
  PVector centroid;
  PVector mid_p1p2,mid_p2p3,mid_p3p1,innP1,innP2,innP3;
  TriangularPanel(PVector _p1,PVector _p2,PVector _p3) {
    p1=_p1;
    p2=_p2;
    p3=_p3;
    q_pts=new PVector[6];
    construct();
  }
  void construct() {
    //middle points of each edge
    mid_p1p2=PVector.sub(p1,p2);
    mid_p1p2.normalize();   
    mid_p1p2.mult(p1.dist(p2)/2);
    mid_p1p2.add(p2);
 
    mid_p2p3=PVector.sub(p2,p3);
    mid_p2p3.normalize();   
    mid_p2p3.mult(p2.dist(p3)/2);
    mid_p2p3.add(p3);
 
    mid_p3p1=PVector.sub(p3,p1);
    mid_p3p1.normalize();   
    mid_p3p1.mult(p3.dist(p1)/2);
    mid_p3p1.add(p1);
     
    //triangle centroid
    centroid=PVector.sub(p2,mid_p3p1);
    centroid.normalize();   
    centroid.mult(p2.dist(mid_p3p1)*0.33);
    centroid.add(mid_p3p1);
     
    //scaling parameters
    float par1=noise(atick+centroid.x*sc2,atick+centroid.y*sc2,atick+centroid.z*sc2);//regulates size of each panel
    float par2=noise(atick+centroid.x*sc2,atick+centroid.y*sc2,atick+centroid.z*sc2);//regulates size of inner triangle
 
    //further subdivision
    q_pts[0]=PVector.sub(p1,mid_p1p2);
    q_pts[0].normalize();   
    q_pts[0].mult(p1.dist(mid_p1p2)*par1);
    q_pts[0].add(mid_p1p2);
 
    q_pts[1]=PVector.sub(p2,mid_p1p2);
    q_pts[1].normalize();   
    q_pts[1].mult(p2.dist(mid_p1p2)*par1);
    q_pts[1].add(mid_p1p2);
 
    q_pts[2]=PVector.sub(p2,mid_p2p3);
    q_pts[2].normalize();   
    q_pts[2].mult(p2.dist(mid_p2p3)*par1);
    q_pts[2].add(mid_p2p3);
 
    q_pts[3]=PVector.sub(p3,mid_p2p3);
    q_pts[3].normalize();   
    q_pts[3].mult(p3.dist(mid_p2p3)*par1);
    q_pts[3].add(mid_p2p3);
 
    q_pts[4]=PVector.sub(p3,mid_p3p1);
    q_pts[4].normalize();   
    q_pts[4].mult(p3.dist(mid_p3p1)*par1);
    q_pts[4].add(mid_p3p1);
 
    q_pts[5]=PVector.sub(p1,mid_p3p1);
    q_pts[5].normalize();   
    q_pts[5].mult(p1.dist(mid_p3p1)*par1);
    q_pts[5].add(mid_p3p1);   
 
    //inner triangle points
    innP1=PVector.sub(centroid,mid_p1p2);
    innP1.normalize();   
    innP1.mult(centroid.dist(mid_p1p2)*par2);
    innP1.add(mid_p1p2);
 
    innP2=PVector.sub(centroid,mid_p2p3);
    innP2.normalize();   
    innP2.mult(centroid.dist(mid_p2p3)*par2);
    innP2.add(mid_p2p3);
 
    innP3=PVector.sub(centroid,mid_p3p1);
    innP3.normalize();   
    innP3.mult(centroid.dist(mid_p3p1)*par2);
    innP3.add(mid_p3p1);
  }
 
  void display() {
    fill(noise(atick+p1.x*sc2,atick+p1.y*sc2,atick+p1.z*sc2)* colorlittle,coltriangle,255-noise(atick+p1.x*sc2,atick+p1.y*sc2,atick+p1.z*sc2)*255,opacidad);//regulates color of each segment
//    fill(noise(atick+p1.x*sc2,atick+p1.y*sc2,atick+p1.z*sc2)* 255,col,255-noise(atick+p1.x*sc2,atick+p1.y*sc2,atick+p1.z*sc2)*255,127);//regulates color of each segment
    beginShape();
    vertex(innP1.x,innP1.y,innP1.z);
    vertex(mid_p1p2.x,mid_p1p2.y,mid_p1p2.z);
    vertex(q_pts[0].x,q_pts[0].y,q_pts[0].z);
    vertex(q_pts[5].x,q_pts[5].y,q_pts[5].z);
    vertex(mid_p3p1.x,mid_p3p1.y,mid_p3p1.z);
    vertex(innP3.x,innP3.y,innP3.z);
    endShape(CLOSE);
    
//    fill(noise(atick+p2.x*sc2,atick+p2.y*sc2,atick+p2.z*sc2)*255,col,255-noise(atick+p2.x*sc2,atick+p2.y*sc2,atick+p2.z*sc2)*col+10,127);//-||-
fill(noise(atick+p2.x*sc2,atick+p2.y*sc2,atick+p2.z*sc2)*255,coltriangle,colorlittle-noise(atick+p2.x*sc2,atick+p2.y*sc2,atick+p2.z*sc2)*255,opacidad);//-||-
        beginShape();
    vertex(innP2.x,innP2.y,innP2.z);
    vertex(mid_p2p3.x,mid_p2p3.y,mid_p2p3.z);
    vertex(q_pts[2].x,q_pts[2].y,q_pts[2].z);
    vertex(q_pts[1].x,q_pts[1].y,q_pts[1].z);
    vertex(mid_p1p2.x,mid_p1p2.y,mid_p1p2.z);
    vertex(innP1.x,innP1.y,innP1.z);
    endShape(CLOSE);
//    fill(noise(atick+p3.x*sc2,atick+p3.y*sc2,atick+p3.z*sc2)*col+10,85,255-noise(atick+p3.x*sc2,atick+p3.y*sc2,atick+p3.z*sc2)*255,127);//-||-
fill(noise(atick+p3.x*sc2,atick+p3.y*sc2,atick+p3.z*sc2)*coltriangle+10,85,colorlittle-noise(atick+p3.x*sc2,atick+p3.y*sc2,atick+p3.z*sc2)*255,opacidad);//-||-
     beginShape();
    vertex(innP3.x,innP3.y,innP3.z);
    vertex(mid_p3p1.x,mid_p3p1.y,mid_p3p1.z);
    vertex(q_pts[4].x,q_pts[4].y,q_pts[4].z);
    vertex(q_pts[3].x,q_pts[3].y,q_pts[3].z);
    vertex(mid_p2p3.x,mid_p2p3.y,mid_p2p3.z);
    vertex(innP2.x,innP2.y,innP2.z);
    endShape(CLOSE);
     
  }
}
