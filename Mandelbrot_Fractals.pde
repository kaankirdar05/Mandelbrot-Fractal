double check = 200;
double lngthMaxX = 2;
double lngthMinX = -2;
double lngthMaxY = 2;
double lngthMinY = -2;

int H = 255*2;
int S = 99*2;
int B = 99*2;

void setup()
{
  size (1000,1000); 
  colorMode(HSB, H,S,B);
}

void draw()
{
  background(255);
  loadPixels();  
  
  for(int x=0;x<width;x++)
  {
    for(int y=0;y<height;y++)
    {      
      double a = maps(x,0,width,lngthMinX,lngthMaxX);
      double b = maps(y,0,height,lngthMaxY,lngthMinY);
      double cx = a;
      double cy = b;
      
      double a2;
      double b2;
      int n2=0;
      
      for(int n = 0; n<check; n++)
      {
       a2 = pow2(true,a,b,cx,cy);
       b2 = pow2(false,a,b,cx,cy);
       a=a2;
       b=b2;
       n2=n;
       if(a*a + b*b > 16)
       {
         break;
       }
      }
      
      if(n2 >= check-1)
      {
        pixels[x+ y*width] = color(0);        
      }
      
      else
      {
        pixels[x+ y*width] = color((int)maps(n2,0,check,H,0),(int)maps(n2,0,check,S,0),(int)maps(n2,0,check,0,B));        
      }
      
    }
  }
  updatePixels();  

}

void mouseClicked()
{
  double maxX = lngthMaxX;
  double maxY = lngthMaxY;
  double minX = lngthMinX;
  double minY = lngthMinY;
  
  if(mouseButton == LEFT){
  lngthMaxX = maps(mouseX+(width/(4)),0,width,minX,maxX);  
  lngthMinX = maps(mouseX-(width/(4)),0,width,minX,maxX);
  lngthMaxY = maps(mouseY-(height/(4)),0,width,maxY,minY);
  lngthMinY = maps(mouseY+(height/(4)),0,width,maxY,minY);  
  println(lngthMinX+" "+lngthMaxX+" , "+ lngthMinY +" "+ lngthMaxY);  
  }
  
  else if(mouseButton == RIGHT)
  {       
  lngthMaxX = maps(mouseX+width,0,width,minX,maxX);  
  lngthMinX = maps(mouseX-width,0,width,minX,maxX);
  lngthMaxY = maps(mouseY-height,0,height,maxY,minY);
  lngthMinY = maps(mouseY+height,0,height,maxY,minY); 
  println(lngthMinX+" "+lngthMaxX+" , "+ lngthMinY +" "+ lngthMaxY);   
  }
  
  else
  {
    lngthMaxX=2;
    lngthMaxY=2;
    lngthMinX=-2;
    lngthMinY=-2;    
  }  
}

double pow2(boolean w, double a, double b, double cx, double cy)
{
  if(w)
  {
    return (a*a) - (b*b) + cx;
  }
  
  else
  {
    return 2*a*b + cy;
  }
}

double pow3(boolean w, double a, double b, double cx, double cy)
{
  if(w)
  {
    return  (a*a*a) - (3*a*b*b) + cx;
  }
  
  else
  {
    return (3*a*a*b) - (b*b*b) + cy;
  }
}

double pow4(boolean w, double a, double b, double cx, double cy)
{
  if(w)
  {
    return pows(a,4) + pows(b,4) - (6*pows(a,2)*pows(b,2)) + cx;
  }
  
  else
  {
    return (4*pows(a,3)*b) - (4*a*pows(b,3)) + cy;
  }
}

double maps(double x, double a, double b, double c, double d)
{
  return (((x-a)/(b-a))*(d-c))+c;
}

double pows(double a, double p)
{
  double b = a;
  for(int x=0;x<p-1;x++)
  {
    a = a*b;
  }
  
  return a;
}
