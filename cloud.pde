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
  RShape path, cloudpath, Cpath;
  int fontsize;
  int finalX;
  color c;
  List<RPoint> backbone = new ArrayList <RPoint>();
  
  
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
    for (int i = 0; i < backbone.size()-1; i++) {
      cloudpath.addLineTo(backbone.get(i).x, backbone.get(i).y - fontsize*2 );
      float interdistX = backbone.get(i+1).x - backbone.get(i).x;
      float interdistY = backbone.get(i+1).y - backbone.get(i).y;
      int bumps = int(noise(i*0.02)*5);
        for (int j=0;j<bumps;j++) {
          cloudpath.addLineTo(backbone.get(i+1).x + interdistX/bumps*(j+1) , backbone.get(i).y - fontsize*2*i/(j+1)  );
        }
    }
    cloudpath.addLineTo(backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
    for (int i = backbone.size(); i > 0; i--) {
      cloudpath.addLineTo(backbone.get(i-1).x, backbone.get(i-1).y + fontsize*2 );
    }
     cloudpath.addLineTo(backbone.get(0).x - fontsize*2 , backbone.get(0).y);
    ///done cacluating cloud
    
    
    
  }
  
  

  
  void drawTris(RGroup textgrp){
    pushMatrix();
    //translate(100,100);
    RCommand.setSegmentLength(15);
    //RShape clouddustgrp = textgrp.toShape();    
    textgrp = textgrp.toPolygonGroup();  
    RPoint[] clouddust = textgrp.getPoints();
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
    popMatrix();
  }
  
  void render(){
    stroke(131,175,155,128);
    fill(249,205,173,15);
    cloudpath.draw();
    //noFill();
    path.draw();
    ///draw clouds
    pushMatrix();
    Cpath = new RShape(cloudpath);
    for (int i = 0; i<10; i++) {
      Cpath.
      translate(0,10-i);
      stroke(254,67,101,128-i*5);
      Cpath.draw();  
    }
    popMatrix();
    
    RCommand.setSegmentLength(1);
    RGroup textgrp = font.toGroup(phrase);
    //stroke(0,255,0,0);
    stroke(131,175,155,15);
    noFill();
    
    ///draw text
    textgrp.adapt(path);
    drawTris(textgrp);
    fill(131,175,155);
    textgrp.draw();
    
    
    

  }
}

  
