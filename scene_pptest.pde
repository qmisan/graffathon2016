void scene_test(PGraphics canvas){
  
  canvas.directionalLight(204, 204, 204, -0.6, -0.6, -1);
  canvas.translate(width/2, height/2);
  canvas.fill(50,190,100);
  canvas.sphere(120);
}