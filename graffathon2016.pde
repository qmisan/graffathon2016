import moonlander.library.*;
import ddf.minim.*;

Moonlander ml;
PShader pp1;
PGraphics canvas;
PFont font;
PImage dogeImg;

String credits[] = {"DEMO BY",
                    "Merilohi (Graphics)",
                    "Okalintu (Graphics)", 
                    "Tatoma (Graphics)",
                    "Marski (Sound)"};

String tech_problems[] = {"Umm we are experiencing minor technical problems",
                    "we lost red color?",
                    "i think we lost all colors?", 
                    "we are losing picture also",
                    "Bye!"};

void setup() {
  size(1280,720,P3D);
  pp1 = loadShader("pp1.glsl");
  canvas = createGraphics(width, height, P3D);
  ml = Moonlander.initWithSoundtrack(this, "biisi/graffathon2.mp3", 130, 4);
  
  // Load images
  dogeImg = loadImage("img/doge.png");
  // Load fonts
  font = createFont("Arial",32,true);
  
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
  
  double cam_rotation = ml.getValue("cam_rotation");
  
  int bg_red   = ml.getIntValue("background_red");
  int bg_green = ml.getIntValue("background_green");
  int bg_blue  = ml.getIntValue("background_blue");
  
  int text_state = ml.getIntValue("text_state");
  
  // Shader Parameters
  float wobblysize = (float) ml.getValue("wobblySize");
  float wobblyspeed = (float) ml.getValue("wobblySpeed");
  float noise = (float) ml.getValue("noise");
  float glowR = (float) ml.getValue("glowR");
  float glowG = (float) ml.getValue("glowG");
  float glowB = (float) ml.getValue("glowB");
  float bw = (float) ml.getValue("bw");
  float invert = (float) ml.getValue("invert");
  
  // Get current scene
  int scene = ml.getIntValue("scene");
  
  //camera((width/2.0)+(float)cam_pos_x, (height/2.0)+(float)cam_pos_y,  (height/ tan(PI*30.0 / 180.0))+(float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0, 1, 0);
  canvas.beginCamera();
  canvas.camera((width/2.0)+(float)cam_pos_x, (height/2.0)+(float)cam_pos_y, ((height/2.0) / tan(PI*30.0 / 180.0))+(float)cam_pos_z, (width/2.0)+(float)cam_dir_x, (height/2.0)+(float)cam_dir_y, (float)cam_dir_z, 0, 1, 0);
  canvas.rotate((float)cam_rotation);
  canvas.endCamera();
  // Run corresponding scene
  canvas.beginDraw();
  //canvas.camera((float)cam_pos_x, (float)cam_pos_y, (float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0.0, 1.0, 0.0);
  canvas.background(bg_red, bg_green, bg_blue);
  switch (scene){
  case 1:
    scene1(canvas);
    break;
  case 2:
    tree2DScene(canvas);
    break;
  case 3:
    tree3DScene(canvas);
    break;
  case 5:
    sierpinskScene(canvas);
    break;
  case -1:
    scene_test(canvas);
    break;
  case -2:
    scene_doge(canvas);
    break;

  case 99:
    scene_text(canvas,credits,text_state,0.0,0.0);
    break;
  case 100:
    scene_text(canvas,tech_problems,text_state,0.0,0.0);
    break;
  }

  canvas.endDraw();
  
  // Post processing
  shader(pp1);
  pp1.set("wobblyspeed",wobblyspeed);
  pp1.set("wobblysize",wobblysize);
  pp1.set("noiseSize",noise);
  pp1.set("glowValue",glowR,glowG,glowB);
  pp1.set("time",millis()/1000.0);
  pp1.set("bw",bw);
  pp1.set("doInvert",invert);
  image(canvas,0,0); 
}
