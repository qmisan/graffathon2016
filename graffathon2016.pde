import moonlander.library.*;
 
Moonlander ml;
PShader pp1;
PGraphics canvas;

void setup() {
  size(1600,900,P3D);
  pp1 = loadShader("pp1.glsl");
  canvas = createGraphics(width, height, P3D);
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
  float wobblysize = (float) ml.getValue("wobblySize");
  float wobblyspeed = (float) ml.getValue("wobblySpeed");
  float glowR = (float) ml.getValue("glowR");
  float glowG = (float) ml.getValue("glowG");
  float glowB = (float) ml.getValue("glowB");
  float bw = (float) ml.getValue("bw");
  float invert = (float) ml.getValue("invert");
  
  
<<<<<<< HEAD
  background(bg_red, bg_green, bg_blue);
  //camera((width/2.0)+(float)cam_pos_x, (height/2.0)+(float)cam_pos_y,  (height/ tan(PI*30.0 / 180.0))+(float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0, 1, 0);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
=======
>>>>>>> 3e721e1d0d871a2f43470797d8666b0ff5966c06
  
  // Get current scene
  int scene = ml.getIntValue("scene");
  
  // Run corresponding scene
  canvas.beginDraw();
  //canvas.camera((float)cam_pos_x, (float)cam_pos_y, (float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0.0, 1.0, 0.0);
  canvas.background(bg_red, bg_green, bg_blue);
  switch (scene){
  case 1:
    scene1(canvas);
    break;
  case 2:
    scene2(canvas);
    break;
  case -1:
    scene_test(canvas);
    break;
  }
  canvas.endDraw();
  // post processing
  shader(pp1);
  pp1.set("wobblyspeed",wobblyspeed);
  pp1.set("wobblysize",wobblysize);
  pp1.set("glowValue",glowR,glowG,glowB);
  pp1.set("time",millis()/1000.0);
  pp1.set("bw",bw);
  pp1.set("doInvert",invert);
  image(canvas,0,0); 
}
