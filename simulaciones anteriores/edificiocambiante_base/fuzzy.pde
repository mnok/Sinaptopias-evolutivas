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


