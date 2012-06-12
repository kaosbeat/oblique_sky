class Cloud{
  //import geomerative.RPoint;
  float x;
  float y;
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
  
  
  Cloud(float x, float y, color c, int fontsize,String phrase){
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
    
    backbone.add(new RPoint(this.x,this.y));
    for(int i = 0;i<words.length;i++){
      stretch = words[i].length()*fontsize; 
      this.x = this.x + int(stretch);
      this.y = this.y+fontsize*random(-2,2);
      path.addLineTo(this.x , this.y);
      backbone.add(new RPoint(this.x,this.y));
    }  
    
    ///now calculate cloud around backbone
    cloudpath = new RShape();
    cloudpath.addMoveTo(backbone.get(0).x - fontsize*2 , backbone.get(0).y);
    for (int i = 0; i < backbone.size()-1; i++) {
      if (curved == true) {
      float px = backbone.get(i).x;
      float py = backbone.get(i).y;
      float c1x = px + random(-100,0);
      float c1y = py + random(-100,0);
      float c2x = px + random(0,100);
      float c2y = py + random(0,100);
      cloudpath.addBezierTo(c1x,c1y,c2x,c2y,px,py);
      } else {
        float interdistX = backbone.get(i+1).x - backbone.get(i).x;
        float interdistY = backbone.get(i+1).y - backbone.get(i).y;
        int bumps = int(noise(i*0.02)*5);  
        cloudpath.addLineTo(backbone.get(i).x, backbone.get(i).y - fontsize*2 );  
        for(int j=0;j<bumps;j++) {
          cloudpath.addLineTo(backbone.get(i+1).x + interdistX/bumps*(j+1) , backbone.get(i).y - fontsize*i/(j+1) );//+ fontsize*2*j/(j+1) );
        }
      cloudpath.addLineTo(backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
      }
    }
    if (curved == true) {
      float cpx = backbone.get(backbone.size()-1).x;
      float cpy = backbone.get(backbone.size()-1).y;
      cloudpath.addBezierTo(cpx +random(-10,0),cpy + random(-10,0),cpx + random(0,10), cpy + random(0,10),backbone.get(backbone.size()-1).x + fontsize*2 , backbone.get(backbone.size()-1).y);
    }
    for (int i = backbone.size(); i > 0; i--) {
      if (curved == true) {
        float px = backbone.get(i-1).x;
        float py = backbone.get(i-1).y + fontsize*5;
        float c1x = px - random(-100,0);
        float c1y = py - random(-100,0);
        float c2x = px - random(0,100);
        float c2y = py - random(0,100);
        cloudpath.addBezierTo(c1x,c1y,c2x,c2y,px,py);
      } else {
        cloudpath.addLineTo(backbone.get(i-1).x, backbone.get(i-1).y + fontsize*2 );
        float interdistX = backbone.get(i-1).x - backbone.get(i-1).x;
        float interdistY = backbone.get(i-1).y - backbone.get(i-1).y;
        int bumps = int(noise(i*0.02)*5);
      }
    }
     cloudpath.addLineTo(backbone.get(0).x - fontsize*2 , backbone.get(0).y);
    ///done cacluating cloud
  }
  
  

  
  void drawTris(RGroup textgrp){
    pushMatrix();
    //translate(0,5*fontsize);
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
  
  void drawclouds(int clouds) {
    pushMatrix();
    Cpath = new RShape(cloudpath);
    for (int i = 0; i<clouds; i++) {
      translate(0,clouds-i);
      stroke(red(liningCol),green(liningCol),blue(liningCol),alpha(liningCol)-i*15);
      println();
      fill(red(cloudCol),green(cloudCol),blue(cloudCol),alpha(cloudCol)-i*5);
      Cpath.draw();  
    }
    popMatrix();   
  }
  
  
  void render(){
    pushMatrix();
    translate(0,5*fontsize);
    //cloudpath.draw();
    noFill();
    stroke(red(backboneCol),green(backboneCol),blue(backboneCol),alpha(backboneCol));
    path.draw();
    //drawclouds(10);
    RCommand.setSegmentLength(1);
    RGroup textgrp = font.toGroup(phrase);
    noFill();
    ///draw text
    textgrp.adapt(path);
    stroke(red(trisCol),green(trisCol),blue(trisCol),alpha(trisCol));
    drawTris(textgrp);
    noStroke();
    fill(red(textCol),green(textCol),blue(textCol),alpha(textCol));
    //pushMatrix();
    //translate(0,fontsize*5);
    textgrp.draw();
    //popMatrix();
    popMatrix();
    

  }
}

  
