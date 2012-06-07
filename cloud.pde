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
    for (int i = 0; i < backbone.size()-1; i++) {
      float px = backbone.get(i).x;
      float py = backbone.get(i).y;
      float c1x = px + random(-100,0);
      float c1y = py + random(-100,0);
      float c2x = px + random(0,100);
      float c2y = py + random(0,100);
      //cloudpath.addLineTo(backbone.get(i).x, backbone.get(i).y - fontsize*2 );
      cloudpath.addBezierTo(c1x,c1y,c2x,c2y,px,py);
      float interdistX = backbone.get(i+1).x - backbone.get(i).x;
      float interdistY = backbone.get(i+1).y - backbone.get(i).y;
      int bumps = int(noise(i*0.02)*5);
      for (int j=0;j<bumps;j++) {
          //cloudpath.addLineTo(backbone.get(i+1).x + interdistX/bumps*(j+1) , backbone.get(i).y - fontsize*i/(j+1) );//+ fontsize*2*j/(j+1) );
        }
    }
    //cloudpath.addLineTo(backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
    float cpx = backbone.get(backbone.size()-1).x;
    float cpy = backbone.get(backbone.size()-1).y;
    cloudpath.addBezierTo(cpx +random(-10,0),cpy + random(-10,0),cpx + random(0,10), cpy + random(0,10),backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
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
    fill(249,205,173,15);
    //cloudpath.draw();
    //noFill();
    //stroke(131,175,155,128);
    //path.draw();
    ///draw clouds
    pushMatrix();
    Cpath = new RShape(cloudpath);
    noStroke();
    stroke(0);
    for (int i = 0; i<10; i++) {
      //Cpath.
      translate(0,10-i);
      //stroke(254,67,101,128-i*5);
      fill(254,67,101,128-i*5);
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
    //drawTris(textgrp);
    fill(131,175,155);
    pushMatrix();
    translate(0,fontsize*3);
    textgrp.draw();
    popMatrix();
    
    

  }
}

  
