import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import org.jbox2d.common.*;
import processing.pdf.*;

boolean saved = false;
Cloud[] cloudysky = new Cloud[127];
RFont font;
float counter = 0;
int fontsize = 15;
String phrase;
float x,y;
int times;
color cloudCol, liningCol, textCol, trisCol, backboneCol, b1, b2;
boolean curved = false;


void setup() {
 frameRate(10);
 String[] ob = new String[127];
 populateob(ob);
  size(1900,400,P3D);
 background(255);
 cloudCol = color(236,208,120,255);
 liningCol = color(84,36,55);
 textCol = color(83,119,122);
 trisCol = color(84,36,55,50);
 backboneCol = color(255,255,0,128);
 b1 = color(157,188,188,255);
 b2 = color(157,188,188,255);
 smooth();
 times = 127; 
 RG.init(this);
 font = new RFont("altehaasgroteskregular-webfont.ttf");
 font.setSize(fontsize);
 font.setAlign(RFont.LEFT);
 cloudysky[0] = new Cloud(x,y,color(255),fontsize,ob[0]); 
 for (int i=1;i<times-1;i++) { 
  phrase = ob[i];
  //if (cloudysky[i-1].x + phrase.length()*fontsize + 2*fontsize > width/2) {
  if (cloudysky[i-1].x + phrase.length()*fontsize > width){
   x = random(3*fontsize,5*fontsize);
   y = y + 3*fontsize;
  } else {
   //println("values: " + cloudysky[i-1].x);
   x = cloudysky[i-1].x + random(5*fontsize,8*fontsize);
   y = y ;//+ random(-3*fontsize,3*fontsize);
  } 
   cloudysky[i] = new Cloud(x,y,color(128 +i*18),fontsize,phrase);
  }
}



void draw() {
  //beginRecord(PDF, "test.pdf");
    background(255);
    //setGradient(0, 0, width, height, b1, b2, 1);
    //translate(width/2-10,height/2+30);
    
    for (int i=0;i<times-1;i++) {
      println("render " + i);
      cloudysky[i].render();
    }
   // endRecord();
    if (saved == false) { 
    Date d = new Date();
    long datum = d.getTime();
    save("obliquesky"+datum+".png");
    //String[] params = { "git", "commit", "-a", "-m", "automatic commit at " + datum };
    String[] params = {"git", "commit", "/Users/kaos/Documents/Processing/oblique_sky/*.pde",  "-m", "automatic commit at " + datum };
    saved = true;  
    } 
    
   // println( cloudysky[0].x);
}
