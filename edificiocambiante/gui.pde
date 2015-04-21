//ControlP5 gui;
//ControlWindow controlWindow;
//
//void initGUI() {
//  gui = new ControlP5(this);
//  gui.setAutoDraw(false);
//  controlWindow = gui.addControlWindow("controlP5window", 100, 100, 400, 500);
//  controlWindow.hideCoordinates();  
//  controlWindow.setBackground(color(40));
//  Controller mySlider1 = gui.addSlider("rFreq", 0, 20, 15, 20, 200, 10);
//  Controller mySlider2 = gui.addSlider("gFreq", 0, 20, 15, 40, 200, 10);
//  Controller mySlider3 = gui.addSlider("bFreq", 0, 20, 15, 60, 200, 10);
//  Controller mySlider4 = gui.addSlider("rIntens", 0, 255, 20, 100, 200, 10);
//  Controller mySlider5 = gui.addSlider("gIntens", 0, 255, 20, 120, 200, 10);
//  Controller mySlider6 = gui.addSlider("bIntens", 0, 255, 20, 140, 200, 10);
//  Controller mySlider7 = gui.addSlider("bcgColor", 0, 255, 20, 180, 200, 10);
//  Controller mySlider8 = gui.addSlider("slabTreshold", 0.001, 0.3, 20, 220, 200, 10);
//  Controller mySlider9 = gui.addSlider("slabColor", 0, 255, 20, 200, 200, 10);
//  Controller myButton1 = gui.addButton("runReaction", 0, 290, 300, 50, 20);
//  Controller myButton2 = gui.addButton("updateColor", 0, 260, 20, 80, 20);
//  Controller myButton3 = gui.addButton("randomFreq", 0, 260, 60, 80, 10);
//  Controller myButton4 = gui.addButton("randomIntens", 0, 260, 100, 80, 10);
//  Controller myButton5 = gui.addButton("smoothIt", 0, 290, 180, 50, 50);
//  Controller myToggle1 = gui.addToggle("colorIndexing", true, 290, 240, 50, 20);
//  mySlider1.setWindow(controlWindow);
//  mySlider2.setWindow(controlWindow);
//  mySlider3.setWindow(controlWindow);
//  mySlider4.setWindow(controlWindow);
//  mySlider5.setWindow(controlWindow);
//  mySlider6.setWindow(controlWindow);
//  mySlider7.setWindow(controlWindow);
//  mySlider8.setWindow(controlWindow);
//  mySlider9.setWindow(controlWindow);
//  myButton1.setWindow(controlWindow);
//  myButton2.setWindow(controlWindow);
//  myButton3.setWindow(controlWindow);
//  myButton4.setWindow(controlWindow);
//  myButton5.setWindow(controlWindow);
//  myToggle1.setWindow(controlWindow);
//}
//
//public void runReaction() {
//  runReaction = !runReaction;
//}
//public void randomFreq() {
//  rFreq = (int)random(20);
//  gFreq = (int)random(20);
//  bFreq = (int)random(20); 
//  gui.controller("rFreq").setValue(rFreq);
//  gui.controller("gFreq").setValue(gFreq);
//  gui.controller("bFreq").setValue(bFreq);
//  updateColors();
//}
//
//public void randomIntens() {
//  rIntens =(int)random(255);
//  gIntens =(int)random(255);
//  bIntens =(int)random(255);
//  gui.controller("rIntens").setValue(rIntens);
//  gui.controller("gIntens").setValue(gIntens);
//  gui.controller("bIntens").setValue(bIntens);
//  updateColors();
//}
//
//public void updateColor() {
//  updateColors();
//}
//
//public void smoothIt() {
//  new LaplacianSmooth().filter(mesh, 1);
//}
//
//void colorIndexing(boolean theFlag) {
//  uniform=theFlag;
//}

