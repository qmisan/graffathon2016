int lineStartTime;
int duration = 2000;

void tree2DScene(PGraphics canvas) {
  // Move base matrix abit so recursion starts from bottom
  canvas.translate(canvas.width/2,canvas.height);
  
  // Call for recursive function
  drawTree(canvas.width, canvas.height, ml.getIntValue("depth"));
}

void drawTree(int w, int h, int d) {
  float line_len = -100;

  canvas.line(0,0,0,line_len);
  
  if (d > 0) {
    canvas.translate(0,line_len);
    
    // Right
    canvas.pushMatrix();
    canvas.rotate(PI/6);
    drawTree(w,h,d-1);
    canvas.popMatrix();
    
    // Left
    canvas.pushMatrix();
    canvas.rotate(-PI/6);
    drawTree(w,h,d-1);
    canvas.popMatrix();
  }
}
