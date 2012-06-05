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
    words = phrase.split(" ");
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
    }  
    ///now calculate cloud around backbone
    cloudpath = new RShape();
    cloudpath.addMoveTo(backbone.get(0).x - fontsize*2 , backbone.get(0).y);
    stroke(255,0,0);
    fill(255,255,0);
    for (int i = 0; i < backbone.size(); i++) {
      cloudpath.addLineTo(backbone.get(i).x, backbone.get(i).y - fontsize*2 );
    }
    cloudpath.addLineTo(backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
    for (int i = backbone.size(); i > 0; i--) {
      cloudpath.addLineTo(backbone.get(i-1).x, backbone.get(i-1).y + fontsize*2 );
    }
     cloudpath.addLineTo(backbone.get(0).x - fontsize*2 , backbone.get(0).y);
    ///done cacluating cloud
  }
  
  void drawTris(){
    RCommand.setSegmentLength(15);
    RGroup clouddustgrp = font.toGroup(phrase);
    //RShape clouddustgrp = clouddustgrp.toShape();    
    clouddustgrp = clouddustgrp.toPolygonGroup();  
    RPoint[] clouddust = clouddustgrp.getPoints();
    beginShape(TRIANGLE_STRIP);
    for (int i=0; i < clouddust.length; i++) {
     vertex(clouddust[i].x, clouddust[i].y);
     if (i%5 == 0) {
         currentmeshpointX = clouddust[i].x + noise(i*0.04)*fontsize;
       if (clouddust[i].y + fontsize > fontsize/2) {
         currentmeshpointY = clouddust[i].y + noise(i*0.02)*fontsize;    
       } else { 
         currentmeshpointY = clouddust[i].y - noise(i*0.02)*fontsize;
       }
     }
     vertex(currentmeshpointX, currentmeshpointY);
    }
    endShape();
  }
  
  void render(){
    stroke(255,0,0);
    fill(0,0,255,15);
    cloudpath.draw();
    noFill();
    path.draw();
    RCommand.setSegmentLength(1);
    RGroup textgrp = font.toGroup(phrase);
    stroke(0,255,0,0);
    stroke(255,0,100,50);
    noFill();
    drawTris();
    
    ///draw text
    textgrp.adapt(path);
    fill(255,15,36);
    textgrp.draw();

  }
}





    
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
       
    
    //  RCommand.setSegmentLength(mouseX/2+6);
   //for (int i=0; i < clouddust.length; i++) {
     //  if (i%25 == 0) { 
     //    noStroke();
     //    fill(128,128);
     //    rect(clouddust[i].x-35,clouddust[i].y-35,70,70);
     //   }
     //} 
   
   */
