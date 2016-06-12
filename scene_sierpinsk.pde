void sierpinskScene(PGraphics canvas) {
  // Move base matrix abit so recursion starts from bottom
  float p1[] = {100,100,100};
  float p2[] = {-100,-100,100};
  float p3[] = {-100,100,-100};
  float p4[] = {100,-100,-100};
  canvas.beginShape(POINTS);
  fill(255);
  sierpinsk(p1,p2,p3,p4,0,3);
  canvas.endShape();
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
  vertex(p1[0],p1[1],p1[2]);
  vertex(p2[0],p2[1],p2[2]);
  vertex(p3[0],p3[1],p3[2]);
}