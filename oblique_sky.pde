import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import org.jbox2d.common.*;

boolean saved = false;
Cloud[] cloudysky = new Cloud[127];
RFont font;
float counter = 0;
int fontsize = 20;



void setup() {
    frameRate(1);
   String[] ob = new String[127];
   populateob(ob);
   println();
   size(960,300,P3D);
   background(255);
   smooth();
    
  RG.init(this);
  font = new RFont("altehaasgroteskregular-webfont.ttf");
  font.setSize(fontsize);
  font.setAlign(RFont.LEFT);
   
  noStroke();
  fill(0);
  //cloudysky[0] = new Cloud(30,40,ob[int(random(0,127))] );
  for (int i=0;i<10;i++) {
   float fontscale = random(0,1)*fontsize;
   cloudysky[i] = new Cloud(i*fontsize+int(random(0,127))-width/2,i*fontsize-height/2,0.1*i, fontscale, ob[int(random(0,127))] ); 
  }
  
}



void draw() {
    background(0);
    translate(width/2-10,height/2+30);
    for (int i=0;i<10;i++) {
      cloudysky[i].render();
    }
    if (saved == false) { 
    Date d = new Date();
    save("obliquesky"+d.getTime()+".png");
    saved = true;  
    } 
    
    
}
