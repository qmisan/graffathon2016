void scene1() {
  drawCircle(width/2 ,height/2, 200);
}

void drawCircle(int x, int y, float radius) {
  pushMatrix();
  fill(random(0,255), random(0,255), random(0,255));
  ellipse(x, y, radius, radius);
  popMatrix();
  if(radius > 2) {
    radius *= 0.75f;
    drawCircle(x, y, radius);
  }
}