import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;
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
      fill(255, 0, 0);
      beginShape(QUADS);
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
        vertex(vertices[j+4*i].x, vertices[j+4*i].y, vertices[j+4*i].z);
      }
      endShape();
    }
  }
   // Update location
  void update() {
    position.add(velocity);
    
  }
  // Display method
  void display() {
    pushMatrix();
    translate(position.x-w/2, position.y-h/2, position.z);
    //rotateX(frameCount*PI/rotation.x);
    //rotateY(frameCount*PI/rotation.y);
    //rotateZ(frameCount*PI/rotation.z);
    noStroke();
    drawCube(); // Farm out shape to another method
    popMatrix();
  }
}
Minim minim;
AudioInput  ap;
AudioPlayer app;
FFT          fft;
BeatDetect beat;
//Moonlander ml = new Moonlander(this, new TimeController(4));
Bar[] bars = new Bar[512/2+1];


void drawBars(float x, float y) {
    
    //rotateY(0.2);
    box(x, y, 20);
    fill(204);
    stroke(255,0,0);
}

void stop()
{
  //original comment : always close Minim audio classes when you are done with them
  ap.close();
  minim.stop();

  super.stop();
}
