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
  
  // Get current scene
  int scene = moonlander.getIntValue("scene");
  
  // Run corresponding scene
  if (scene == 1)
  {
    scene1();
  }
}
  