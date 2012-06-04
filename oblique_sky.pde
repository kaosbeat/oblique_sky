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
   println();
   size(960,200,P2D);
   background(255);
   smooth();
    
  RG.init(this);
  font = new RFont("altehaasgroteskregular-webfont.ttf");
  font.setSize(50);
  font.setAlign(RFont.CENTER);
   
  noStroke();
  fill(0);
  colorMode(HSB,100); 
  cloudysky[0] = new Cloud(30,40,ob[int(random(0,127))] );
}



void draw() {
    background(100);
    translate(width/2-10,height/2+30);
    cloudysky[0].render();
    if (saved == false) { 
    Date d = new Date();
    save("obliquesky"+d.getTime()+".png");
    saved = true;  
    } 
    
    
}
