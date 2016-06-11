void scene2(PGraphics canvas) {
  // Call for recursive function
  drawTree(canvas, canvas.width, canvas.height, 5);
}

void drawTree(PGraphics canvas, float w, float h, int d) {
  canvas.translate(w/2,h);

  canvas.line(0,0,0,-100);
  canvas.translate(0,-100);
 
  canvas.pushMatrix();
  canvas.rotate(PI/6);
  if(d > 0) {
  drawTree(canvas,w-1,h-1,d-1);
  }
  //line(0,0,0,-100);
  canvas.popMatrix();
 
  //rotate(-PI/6);
  
  //line(0,0,0,-100);
}