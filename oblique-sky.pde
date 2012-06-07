import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import org.jbox2d.common.*;
import processing.pdf.*;

boolean saved = false;
Cloud[] cloudysky = new Cloud[127];
RFont font;
float counter = 0;
int fontsize =15;
String phrase;
float x,y;
int times;
color cloudCol, liningCol, textCol;


void setup() {
 frameRate(10);
 String[] ob = new String[127];
 populateob(ob);
  size(1800,600,P3D);
 background(255);
 cloudCol = color(125,32,65,87);
 liningCol = color(0);
 textCol = color(152,44,45);
 smooth();
 times = 10; 
 RG.init(this);
 font = new RFont("altehaasgroteskregular-webfont.ttf");
 font.setSize(fontsize);
 font.setAlign(RFont.LEFT);
 cloudysky[]
 for (int i=1;i<times;i++) { 
  phrase = ob[int(random(0,127))];
  //if (cloudysky[i-1].x + phrase.length()*fontsize + 2*fontsize > width/2) {
  if (cloudysky[i-1].x + phrase.length()*fontsize > width){
   x = random(5*fontsize,8*fontsize);
   y = y + 10*fontsize;
  } else {
   //println("values: " + cloudysky[i-1].x);
   x = cloudysky[i-1].x + random(5*fontsize,8*fontsize);
   y = y + random(-3*fontsize,3*fontsize);
  } 
   cloudysky[i] = new Cloud(x,y,color(128 +i*18),fontsize,phrase);
  }
}



void draw() {
  //beginRecord(PDF, "test.pdf");
    background(255);
    //translate(width/2-10,height/2+30);
    
    for (int i=0;i<times;i++) {
      cloudysky[i].render();
    }
   // endRecord();
    if (saved == false) { 
    Date d = new Date();
    save("obliquesky"+d.getTime()+".png");
    
    saved = true;  
    } 
    
   // println( cloudysky[0].x);
}
