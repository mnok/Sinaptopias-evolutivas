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

//fuzzy logic: http://en.wikipedia.org/wiki/Fuzzy_logic

float fTrp(float value, float x0, float x1,float x2, float x3) {//fuzzy trapezoid function
  float result=0;
  float x=value;
  if(x<=x0)result=0;
  else if((x>=x1)&&(x<=x2))result=1;
  else if((x>x0)&&(x<x1))result=(x/(x1-x0))-(x0/(x1-x0));
  else result=constrain((-x/(x3-x2))+(x3/(x3-x2)),0,1);
  return result;
}

float fGrade(float value, float x0, float x1){//fuzzy grade function
  float result=0;
  float x=value;
   if(x<=x0)result=0;
  else if(x>=x1)result=1;
 else{
  result=(x/(x1-x0))-(x0/(x1-x0));
 }
return result; 
}

//fuzzy logical operators:

float fAND(float A, float B) {
  return min(A,B);
}
float fOR(float A, float B) {
  return max(A,B);
}
float fNOT(float A) {
  return 1.0-A;
}


