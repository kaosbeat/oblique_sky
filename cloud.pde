class Cloud{
  int x;
  int y;
  String word;

  
  Cloud(int x, int y, String word){
    this.x = x;
    this.y = y;
    this.word = word;
    stroke(0);

  }
  
  
  void render(){
    noStroke();
    
    RGroup grp = font.toGroup(word);
    grp = grp.toPolygonGroup();    
    RPoint[] clouddust = grp.getPoints();
    RCommand.setSegmentLength(mouseX/2+6);
    stroke(0);
    fill(255,0,100);
    for (int i=0; i < clouddust.length; i++) {
     //rect(clouddust[i].x, clouddust[i].y,20, 20);
    }
    noStroke();
    fill(100,255,0);
    for (int i=0; i < clouddust.length; i++) {
      rect(clouddust[i].x, clouddust[i].y,20, 20);
    }
    RCommand.setSegmentLength(1);
    fill(128);
    stroke(128);
    for (int i=0; i < clouddust.length; i++) {
      ellipse(clouddust[i].x, clouddust[i].y,5, 5);      
    }
    /*
    for (int i=0; i < punkte.length; i++) {
  
    float sinHeight = mouseY/float(height)*30;
      float offsetY = sin(counter+punkte[i].x/width*4)*sinHeight;
   
      ellipse(punkte[i].x, punkte[i].y+offsetY, 4, 4);
    }
    */

  }
}
