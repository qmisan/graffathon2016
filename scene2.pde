void scene2() {
  translate(width/2,height);

  line(0,0,0,-100);
  translate(0,-100);
 
  pushMatrix();
  rotate(PI/6);
  
  line(0,0,0,-100);
  popMatrix();
 
  rotate(-PI/6);
  
  line(0,0,0,-100);

}