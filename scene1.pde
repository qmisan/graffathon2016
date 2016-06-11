void scene1(){
  // Moonlander values :DDD
  int bg_red = moonlander.getIntValue("background_red");
  int bg_green = moonlander.getIntValue("background_green");
  int bg_blue = moonlander.getIntValue("background_blue");
  int cameraPos = moonlander.getIntValue("camera_position");
  
  // backgroud colour
  background(bg_red, bg_green, bg_blue);
  drawCircle(width/2 ,height/2, cameraPos);
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