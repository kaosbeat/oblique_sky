class Cloud{
  //import geomerative.RPoint;
  int x;
  int y;
  float r;
  float fontscale;
  String phrase;
  String[] words;
  float currentmeshpointX;
  float currentmeshpointY;
  float stretch;
 // baseshape RShape;
  RShape path, cloudpath;
  int fontsize;
  int finalX;
  color c;
  List<RPoint> backbone = new ArrayList <RPoint>();;
  
  
  Cloud(int x, int y, color c, int fontsize,String phrase){
    this.x = x;
    this.y = y;
    this.c = c;
    this.phrase = phrase;
    //words = new String[];
    words = phrase.split(" ");
    //x = x-width/2;
    //y = y-height/2;
    stroke(0);
    this.r = r;
    this.fontsize = fontsize;
    path = new RShape();
    path.addMoveTo(this.x,this.y);
    backbone.add(new RPoint(float(this.x),float(this.y)));
    for(int i = 0;i<words.length;i++){
      stretch = words[i].length()*fontsize; 
      this.x = this.x + int(stretch);
      this.y = this.y+int(fontsize*random(-2,2));
      path.addLineTo(this.x , this.y);
      backbone.add(new RPoint(float(this.x),float(this.y)));
      
      //println(x + ", " + y + "," + stretch + ", " + fontsize);
      //path.addBezierTo(x+20,y,x+40,y+20, x+30,y+10);
      //path.addBezierTo(x+stretch,y-20,x+stretch+40,y+20, x+stretch+20,y+10);
    }  
    ///now draw cloud around backbone
    cloudpath = new RShape();
    cloudpath.addMoveTo(x,y);
    
    
    
  }
  
  
  void render(){
    stroke(c);
    path.draw();
    RCommand.setSegmentLength(15);
    RGroup grp = font.toGroup(phrase);
    //font.draw(phrase);
    //grp.translate(x,y);
    //grp.scale(fontscale);
    //grp.rotate(r);
    fill(255,255,255,128);
    grp.adapt(path);
    grp.draw();
    
   
    
    
    
    RShape grpshape = grp.toShape();    
    grp = grp.toPolygonGroup();  
    RPoint[] clouddust = grp.getPoints();
    
    
    //  RCommand.setSegmentLength(mouseX/2+6);
   //for (int i=0; i < clouddust.length; i++) {
     //  if (i%25 == 0) { 
     //    noStroke();
     //    fill(128,128);
     //    rect(clouddust[i].x-35,clouddust[i].y-35,70,70);
     //   }
     //} 
  
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
    
    /*
    noStroke();
    fill(255);

  //  RCommand.setSegmentLength(1);
    //fill(255,255,255,128);
    noFill();
    stroke(255);
    for (int i=0; i < clouddust.length; i++) {
     ellipse(clouddust[i].x, clouddust[i].y,5, 5);    
   
     
   }
   */

  }
}
