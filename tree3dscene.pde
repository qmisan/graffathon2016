void tree3DScene(PGraphics canvas) {
  // Move base matrix abit so recursion starts from bottom
  canvas.translate(canvas.width/2, canvas.height);
  canvas.strokeWeight(4);  // Thicker
  // Call for recursive function
  drawTree(canvas.width, canvas.height, ml.getIntValue("depth"), color(255, 0, 0), -100.0);
}

void drawTree(int w, int h, int d, color c, float line_len) {
  canvas.fill(c);

  canvas.line(0,0,0,line_len);
  
  if (d > 0) {
    canvas.translate(0,line_len);
    
    // Right
    canvas.pushMatrix();
    canvas.rotate(PI/6);
    drawTree(w,h,d-1,(c+55)%255,line_len);
    canvas.popMatrix();
    
    // Left
    canvas.pushMatrix();
    canvas.rotate(-PI/6);
    drawTree(w,h,d-1,(c+55)%255, line_len);
    canvas.popMatrix();
  }
}
