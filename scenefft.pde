


void scene_fft(PGraphics canvas) {
  println(bars.length);
  for(int i = 0; i < bars.length; i++) {
    bars[i] =  new Bar(10, 50, 20);
    bars[i].position.add(new PVector(11*i, 0, 0));
    //bars[i].display();
  }
  canvas.lights();
 
  fft.forward(ap.mix);
  fft.linAverages(30);
  //println(fft.avgSize());
  
  for (int i = 0; i < fft.avgSize(); i++) {
    //println(fft.getBand(i)*4);
    bars[i].h = 10 + fft.getBand(i)*3;
    bars[i].update();
    bars[i].display();
  }
  delay(50);
}

void drawBars(float x, float y) {
    
    canvas.box(x, y, 20);
    canvas.fill(204);
    canvas.stroke(255,0,0);
}