void scene2() {
  // Call for recursive function
  drawTree(width, height, 5);
}

void drawTree(float w, float h, int d) {
  translate(w/2,h);

  line(0,0,0,-100);
  translate(0,-100);
 
  pushMatrix();
  rotate(PI/6);
  if(d > 0) {
  drawTree(w-1,h-1,d-1);
  }
  //line(0,0,0,-100);
  popMatrix();
 
  //rotate(-PI/6);
  
  //line(0,0,0,-100);
}