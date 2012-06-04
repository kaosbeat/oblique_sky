import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
boolean saved = false;

RFont font;
float counter = 0;



void setup() {
   size(960,300,P2D);
   background(255);
   smooth();
    
  RG.init(this);
  font = new RFont("altehaasgroteskregular-webfont.ttf");
  font.setSize(200);
  font.setAlign(RFont.CENTER);
   
  noStroke();
  fill(0);
  colorMode(HSB,100); 
}



void draw() {
    background(100);
    translate(width/2-10,height/2+30);
     
    RCommand.setSegmentLength(mouseX/2+6);
     
    RGroup grp = font.toGroup("Wave");
    grp = grp.toPolygonGroup();
    RPoint[] punkte = grp.getPoints();
     
    noStroke();
    fill(0,100,100);
    for (int i=0; i < punkte.length; i++) {
  
     float sinHeight = mouseY/float(height)*30;
      float offsetY = sin(counter+punkte[i].x/width*4)*sinHeight;
   
      ellipse(punkte[i].x, punkte[i].y+offsetY, 4, 4);
    }
    if (saved == false) { 
    Date d = new Date();
    save("obliquesky"+d.getTime()+".png");
    saved = true;  
    } 
    
    
}
