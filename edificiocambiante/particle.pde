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

class Particle {
  Vec3D pos;//using toxi's Vec3D instead of PVector-VolumetricBrush requirements
  float speed;
  int spread=95; 
  Particle() {
    pos=new Vec3D(random(-spread,spread),random(-spread,spread),random(-spread,spread));
    speed=100;
  }
  void behave() {   
    pos.x+=(noise(i,pos.x*sc2,pos.y*sc2)-.5)*speed;
    pos.y+=(noise(i+1,pos.x*sc2,pos.z*sc2)-.5)*speed;
    pos.z+=(noise(i+2,pos.x*sc2,pos.y*sc2)-.5)*speed;
  }
  void display() {
    brush2.drawAtAbsolutePos(pos,brushDensity);//drawing particle paths with volumetric brush
    brush3.drawAtAbsolutePos(pos,brushDensity2);//drawing particle paths with volumetric brush
  }
}
