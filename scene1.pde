void scene1(PGraphics canvas) {
  drawCircle(canvas,canvas.width/2 ,canvas.height/2, 200);
}

void drawCircle(PGraphics canvas, int x, int y, float radius) {
  canvas.pushMatrix();
  canvas.fill(random(0,255), random(0,255), random(0,255));
  canvas.ellipse(x, y, radius, radius);
  canvas.popMatrix();
  if(radius > 2) {
    radius *= 0.75f;
    drawCircle(canvas,x, y, radius);
  }
}