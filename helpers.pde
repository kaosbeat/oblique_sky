void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ){
  float deltaR = red(c2)-red(c1);
  float deltaG = green(c2)-green(c1);
  float deltaB = blue(c2)-blue(c1);
  float deltaA = alpha(c2)-alpha(c1);
  for (int j = y; j<=(y+h); j++){
          color c = color(
          (red(c1)+(j-y)*(deltaR/h)),
          (green(c1)+(j-y)*(deltaG/h)),
          (blue(c1)+(j-y)*(deltaB/h)),
          (alpha(c1)+(j-y)*(deltaA/h)) 
            );
         stroke(c);
         line(0,j,w,j);
        }
} 
