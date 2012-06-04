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
    
    RGroup grp = font.toGroup(word);
    grp = grp.toPolygonGroup();
    RPoint[] punkte = grp.getPoints();
    noStroke();
    fill(0,100,100);
    for (int i=0; i < punkte.length; i++) {
  
     float sinHeight = mouseY/float(height)*30;
      float offsetY = sin(counter+punkte[i].x/width*4)*sinHeight;
   
      ellipse(punkte[i].x, punkte[i].y+offsetY, 4, 4);
    }
   fill(255,128,18);
   rect (20,20,20,20); 
  }
}
