int lineStartTime;
int duration = 2000;

void tree3DScene(PGraphics canvas) {
  // Move base matrix abit so recursion starts from bottom
  canvas.translate(canvas.width/2,canvas.height);
  
  // Call for recursive function
  drawTree(canvas.width, canvas.height, ml.getIntValue("depth"));
}

void drawTree(float w, float h, int d) {
  float line_len = -100;
  // Draw a line
  if (d == 0) // Last is drawn slowly
  {
    int lineStartTime = millis();
    line_len = increaseLine();
    canvas.line(0,0,0,line_len);
  }
  else if (d > 0) {
    canvas.line(0,0,0,line_len);
    canvas.translate(0,-100);
    
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

float increaseLine() {
    float progress = (float)(millis()-lineStartTime)/duration;
    if(progress <= 1.0) return (-100 * progress);
    else return -100.0;
}
