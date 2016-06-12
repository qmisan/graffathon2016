

void sierpinskScene(PGraphics canvas) {
  int depth = ml.getIntValue("depth");
  // Move base matrix abit so recursion starts from bottom
  float s = 200;
  float p1[] = {s,s,s};
  float p2[] = {s,s,-s};
  float p3[] = {s,-s,s};
  float p4[] = {s,-s,-s};
  float p5[] = {-s,s,s};
  float p6[] = {-s,s,-s};
  float p7[] = {-s,-s,s};
  float p8[] = {-s,-s,-s};

  float mp1[] = midpoint(p1,p2);
  float mp2[] = midpoint(p1,p3);
  float mp3[] = midpoint(p1,p5);
  float mp4[] = midpoint(p2,p4);
  float mp5[] = midpoint(p2,p6);
  float mp6[] = midpoint(p3,p4);
  float mp7[] = midpoint(p3,p7);
  float mp8[] = midpoint(p4,p8);
  float mp9[] = midpoint(p5,p6);
  float mp10[] = midpoint(p5,p7);
  float mp11[] = midpoint(p6,p8);
  float mp12[] = midpoint(p7,p8);
  
  

  canvas.pushMatrix();
  canvas.translate(canvas.width/2, canvas.height/2,0);
  canvas.rotateX(millis()/1000.0);
  canvas.rotateY(millis()/1000.0);
  canvas.beginShape(TRIANGLES);
  canvas.fill(255);
  sierpinsk(p1,mp1,mp2,mp3,0,depth);
  sierpinsk(p2,mp1,mp4,mp5,0,depth);
  sierpinsk(p3,mp2,mp6,mp7,0,depth);
  sierpinsk(p4,mp4,mp6,mp8,0,depth);
  sierpinsk(p5,mp3,mp9,mp10,0,depth);
  sierpinsk(p6,mp5,mp9,mp11,0,depth);
  sierpinsk(p7,mp7,mp10,mp12,0,depth);
  sierpinsk(p8,mp8,mp11,mp12,0,depth);
  canvas.endShape();
  canvas.popMatrix();
}

void sierpinsk(float p1[],float p2[],float p3[],float p4[],int depth, int maxDepth){

  if (depth >= maxDepth){
    drawTriangles(p1,p2,p3,p4);
    return;
  }
  
  float mp1[] = midpoint(p1,p2);
  float mp2[] = midpoint(p1,p3);
  float mp3[] = midpoint(p1,p4);
  float mp4[] = midpoint(p2,p3);
  float mp5[] = midpoint(p2,p4);
  float mp6[] = midpoint(p3,p4);
  
  sierpinsk(p1,mp1,mp2,mp3, depth+1,maxDepth);
  sierpinsk(p2,mp1,mp4,mp5, depth+1,maxDepth);
  sierpinsk(p3,mp2,mp4,mp6, depth+1,maxDepth);
  sierpinsk(p4,mp3,mp5,mp6, depth+1,maxDepth);
  
}
float[] midpoint(float p1[],float p2[]){
  float result[] = {(p1[0]+p2[0])/2.0,(p1[1]+p2[1])/2.0,(p1[2]+p2[2])/2.0};
  return result;
}
void drawTriangles(float p1[],float p2[],float p3[],float p4[]){

  drawTriangle(p1,p2,p3);
  drawTriangle(p1,p2,p4);
  drawTriangle(p1,p3,p4);
  drawTriangle(p2,p3,p4);
}
void drawTriangle(float p1[],float p2[],float p3[]){
  canvas.vertex(p1[0],p1[1],p1[2]);
  canvas.vertex(p2[0],p2[1],p2[2]);
  canvas.vertex(p3[0],p3[1],p3[2]);
}