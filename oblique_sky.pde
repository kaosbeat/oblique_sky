import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
boolean saved = false;
Cloud[] cloudysky = new Cloud[127];
RFont font;
float counter = 0;



void setup() {
   String[] ob = new String[127];
   populateob(ob);
   println(ob[int(random(0,127))]);
   size(960,200,P2D);
   background(255);
   smooth();
    
  RG.init(this);
  font = new RFont("altehaasgroteskregular-webfont.ttf");
  font.setSize(200);
  font.setAlign(RFont.CENTER);
   
  noStroke();
  fill(0);
  colorMode(HSB,100); 
  cloudysky[0] = new Cloud(30,40, "cloudy");
}



void draw() {
    background(100);
    translate(width/2-10,height/2+30);
     
    RCommand.setSegmentLength(mouseX/2+6);
    
    cloudysky[0].render();
    if (saved == false) { 
    Date d = new Date();
    save("obliquesky"+d.getTime()+".png");
    saved = true;  
    } 
    
    
}
