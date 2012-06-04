class Cloud{
  int x;
  int y;
  String word;
  float currentmeshpointX;
  float currentmeshpointY;
  
  Cloud(int x, int y, String word){
    this.x = x;
    this.y = y;
    this.word = word;
    stroke(0);

  }
  
  
  void render(){
    
    RCommand.setSegmentLength(15);
    RGroup grp = font.toGroup(word);
    grp.translate(0,0);
    RShape grpshape = grp.toShape();    
    grp = grp.toPolygonGroup();  
    RPoint[] clouddust = grp.getPoints();
  //  RCommand.setSegmentLength(mouseX/2+6);
    stroke(255,0,100,50);
    //fill(255,0,100);
    noFill();
    //currentmeshpoint.x = clouddust[0].x + random(-20,20);
    beginShape(TRIANGLE_STRIP);
    for (int i=0; i < clouddust.length; i++) {
     vertex(clouddust[i].x, clouddust[i].y);
     if (i%5 == 0) {
         currentmeshpointX = clouddust[i].x + noise(i*0.04)*fontsize;
       if (clouddust[i].y + fontsize > fontsize/2) {
         currentmeshpointY = clouddust[i].y + noise(i*0.02)*fontsize;
         
       } else { 
         currentmeshpointY = clouddust[i].y - noise(i*0.02)*fontsize;
        // println(clouddust[i].y);
       }
     }
     vertex(currentmeshpointX, currentmeshpointY);
     //rect(clouddust[i].x, clouddust[i].y,20, 20);
    }
    endShape();
    noStroke();
    fill(255);

  //  RCommand.setSegmentLength(1);
    fill(255,128,0,128);
    stroke(0);
   // for (int i=0; i < clouddust.length; i++) {
     // ellipse(clouddust[i].x, clouddust[i].y,5, 5);      
  //  }
    grpshape.draw();
  }
}
