import moonlander.library.*;
 
Moonlander moonlander;

void setup() {
  size(640,360);
  
  moonlander = new Moonlander(this, new TimeController(4));
  
  // Always at the end of setup
  moonlander.start();
}
 
void draw() {
  // Handles communication with Rocket. In player mode
  // does nothing. Must be called at the beginning of draw().
  moonlander.update();
  
  // Moonlander values :DDD
  int bg_red = moonlander.getIntValue("background_red");
  int bg_green = moonlander.getIntValue("background_green");
  int bg_blue = moonlander.getIntValue("background_blue");
  int cameraPos = moonlander.getIntValue("camera_position");
  //in400t recursion = moonlander.getIntValue("circles");
  
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