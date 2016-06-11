import moonlander.library.*;
 
Moonlander ml;

void setup() {
  size(640,480,P3D);
  ml = new Moonlander(this, new TimeController(4));
  // Start with scene 1

  // Always at the end of setup
  ml.start();
}
 
void draw() {
  // Handles communication with Rocket. In player mode
  // does nothing. Must be called at the beginning of draw().
  ml.update();
  
  // Common parameters for all scenes
  double cam_pos_x = ml.getValue("cam_pos_x");
  double cam_pos_y = ml.getValue("cam_pos_y");
  double cam_pos_z = ml.getValue("cam_pos_z");
  
  double cam_dir_x = ml.getValue("cam_dir_x");
  double cam_dir_y = ml.getValue("cam_dir_y");
  double cam_dir_z = ml.getValue("cam_dir_z");
  
  int bg_red   = ml.getIntValue("background_red");
  int bg_green = ml.getIntValue("background_green");
  int bg_blue  = ml.getIntValue("background_blue");
  
  background(bg_red, bg_green, bg_blue);
  camera((float)cam_pos_x, (float)cam_pos_y, (float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0.0, 0.0, 0.0);
  
  // Get current scene
  int scene = ml.getIntValue("scene");
  
  // Run corresponding scene
  if (scene == 1)
  {
    scene1();
  }
  else if (scene == 2)
  {
    scene2();
  }
}
