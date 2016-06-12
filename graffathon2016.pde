
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import moonlander.library.*;

Minim minim;
AudioInput  ap;
FFT          fft;
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
class Bar {
  // Position, velocity vectors
  PVector position;
  PVector velocity;
  // Also using PVector to hold rotation values for 3 axes
  PVector rotation;
  
  
  // Vertices of the cube
  PVector[] vertices = new PVector[24];
  // width, height, depth
  float w, h, d;
  
  // colors for faces of cube
  color[] quadBG = new color[6];

  Bar(float w, float h, float d) {
    this.w = w;
    this.h = h;
    this.d = d;
   
    // Colors are hardcoded
    quadBG[0] = color(0);
    quadBG[1] = color(51);
    quadBG[2] = color(102);
    quadBG[3] = color(153);
    quadBG[4] = color(204);
    quadBG[5] = color(255);
   
    // Start in center
    position = new PVector();
    // Random velocity vector
    velocity = new PVector(0,0,0);
    // Random rotation
    rotation = new PVector(90, 90, 90);

    //   cube composed of 6 quads
    //front
    vertices[0] = new PVector(-w/2, -h/2, d/2);
    vertices[1] = new PVector(w/2, -h/2, d/2);
    vertices[2] = new PVector(w/2, h/2, d/2);
    vertices[3] = new PVector(-w/2, h/2, d/2);
    //left
    vertices[4] = new PVector(-w/2, -h/2, d/2);
    vertices[5] = new PVector(-w/2, -h/2, -d/2);
    vertices[6] = new PVector(-w/2, h/2, -d/2);
    vertices[7] = new PVector(-w/2, h/2, d/2);
    //right
    vertices[8] = new PVector(w/2, -h/2, d/2);
    vertices[9] = new PVector(w/2, -h/2, -d/2);
    vertices[10] = new PVector(w/2, h/2, -d/2);
    vertices[11] = new PVector(w/2, h/2, d/2);
    //back
    vertices[12] = new PVector(-w/2, -h/2, -d/2); 
    vertices[13] = new PVector(w/2, -h/2, -d/2);
    vertices[14] = new PVector(w/2, h/2, -d/2);
    vertices[15] = new PVector(-w/2, h/2, -d/2);
    //top
    vertices[16] = new PVector(-w/2, -h/2, d/2);
    vertices[17] = new PVector(-w/2, -h/2, -d/2);
    vertices[18] = new PVector(w/2, -h/2, -d/2);
    vertices[19] = new PVector(w/2, -h/2, d/2);
    //bottom
    vertices[20] = new PVector(-w/2, h/2, d/2);
    vertices[21] = new PVector(-w/2, h/2, -d/2);
    vertices[22] = new PVector(w/2, h/2, -d/2);
    vertices[23] = new PVector(w/2, h/2, d/2);
  }
 // Cube shape itself
  void drawCube() {
    // Draw cube
    for (int i=0; i<6; i++) {
      canvas.fill(255, 0, 0);
      canvas.beginShape(QUADS);
      //front
    vertices[0] = new PVector(-w/2, -h/2, d/2);
    vertices[1] = new PVector(w/2, -h/2, d/2);
    vertices[2] = new PVector(w/2, h/2, d/2);
    vertices[3] = new PVector(-w/2, h/2, d/2);
    //left
    vertices[4] = new PVector(-w/2, -h/2, d/2);
    vertices[5] = new PVector(-w/2, -h/2, -d/2);
    vertices[6] = new PVector(-w/2, h/2, -d/2);
    vertices[7] = new PVector(-w/2, h/2, d/2);
    //right
    vertices[8] = new PVector(w/2, -h/2, d/2);
    vertices[9] = new PVector(w/2, -h/2, -d/2);
    vertices[10] = new PVector(w/2, h/2, -d/2);
    vertices[11] = new PVector(w/2, h/2, d/2);
    //back
    vertices[12] = new PVector(-w/2, -h/2, -d/2); 
    vertices[13] = new PVector(w/2, -h/2, -d/2);
    vertices[14] = new PVector(w/2, h/2, -d/2);
    vertices[15] = new PVector(-w/2, h/2, -d/2);
    //top
    vertices[16] = new PVector(-w/2, -h/2, d/2);
    vertices[17] = new PVector(-w/2, -h/2, -d/2);
    vertices[18] = new PVector(w/2, -h/2, -d/2);
    vertices[19] = new PVector(w/2, -h/2, d/2);
    //bottom
    vertices[20] = new PVector(-w/2, h/2, d/2);
    vertices[21] = new PVector(-w/2, h/2, -d/2);
    vertices[22] = new PVector(w/2, h/2, -d/2);
    vertices[23] = new PVector(w/2, h/2, d/2);
      for (int j=0; j<4; j++) {
        canvas.vertex(vertices[j+4*i].x, vertices[j+4*i].y, vertices[j+4*i].z);
      }
      canvas.endShape();
    }
  }
   // Update location
  void update() {
    position.add(velocity);
    
  }
  // Display method
  void display() {
    
    canvas.pushMatrix();
    canvas.translate(position.x-w/2, position.y-h/2, position.z);
    //  canvas.translate(canvas.width/2 ,canvas.height/2, 200);
    canvas.noStroke();
    drawCube(); // Farm out shape to another method
    canvas.popMatrix();
  }
}

Bar[] bars = new Bar[1024/2+1];
void setup() {
  size(1280,720,P3D);
  pp1 = loadShader("pp1.glsl");
  canvas = createGraphics(width, height, P3D);
  ml = Moonlander.initWithSoundtrack(this, "biisi/graffathon2.mp3", 130, 4);
  
  // Load images
  dogeImg = loadImage("img/doge.png");
  // Load fonts
  font = createFont("Arial",32,true);
  
  minim = new Minim(this);
  ap = minim.getLineIn(Minim.STEREO, 1024);
  fft = new FFT(ap.bufferSize(),ap.sampleRate());

  
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
  
  double canvas_rotation = ml.getValue("can_rotation");
  
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
  canvas.rotate((float)canvas_rotation);
  canvas.endCamera();
  // Run corresponding scene
  canvas.beginDraw();
  //canvas.camera((float)cam_pos_x, (float)cam_pos_y, (float)cam_pos_z, (float)cam_dir_x, (float)cam_dir_y, (float)cam_dir_z, 0.0, 1.0, 0.0);
  canvas.background(bg_red, bg_green, bg_blue);
  canvas.rotate((float)canvas_rotation);
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
  case 6:
    scene_fft(canvas);
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