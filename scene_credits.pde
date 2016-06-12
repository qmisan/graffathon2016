void scene_credits(PGraphics canvas,int state) {
  int rowsize = 80;
 
  String credits[] = {"Merilohi (Graphics)",
                      "Okalintu (Graphics)", 
                      "Tatoma (Graphics)",
                      "Marski (Sound)"};
  
  state = min(state, credits.length);
  
  canvas.translate(canvas.width/2,canvas.height/2- (state+1)*rowsize/2 ,0);
  canvas.textFont(font,64);
  canvas.textAlign(CENTER);
  canvas.text("DEMO BY",0,0);
  canvas.textFont(font,32);
  for (int i=0;i<state;++i){
    canvas.text(credits[i],0,(i+1)*rowsize);
  }
}