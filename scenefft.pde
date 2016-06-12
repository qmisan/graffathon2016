void scene_fft(PGraphics canvas) {
  ml.update();

  lights();
 
  fft.forward(ap.mix);

  for (int i = 0; i < fft.avgSize(); i++) {  
    bars[i].h = 10 + fft.getBand(i)*4;
    bars[i].update();
    bars[i].display();
  }
  delay(50);
}

void drawBars(float x, float y) {
    
    //rotateY(0.2);
    canvas.box(x, y, 20);
    canvas.fill(204);
    canvas.stroke(255,0,0);
}