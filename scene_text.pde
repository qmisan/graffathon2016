void scene_text(PGraphics canvas, String texts[],int state,float posx, float posy) {
  int rowsize = 60;
  state = min(state, texts.length);
  canvas.translate(canvas.width/2+posx,canvas.height/2+posy- (state+1)*rowsize/2 ,0);
  canvas.textAlign(CENTER);
  canvas.textFont(font,64);
  for (int i=0;i<state;++i){
    canvas.text(texts[i],0,(i+1)*rowsize);
  }
}
