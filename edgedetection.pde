PImage bg;
void setup() {
  size(900, 700);
  bg = loadImage("poles.JPG");
  bg.resize(width,height);
  background(0);
  image(bg, 0, 0);
  
}

void draw(){}

//applies edge detecion on mouse click
void mousePressed() {
  bg.filter(GRAY);
  detectEdge();
  println("done!");
}

void detectEdge() {
  loadPixels();
  color[] edges = new color[width*height];
  for(int x = 0; x<width; x++){
     for(int y = 0; y<height; y++){
      int value = getNewPixelValue(x,y);
      edges[x+y*width] = color(value,value,value);
    }
  }
  for(int i = 0; i<edges.length; i++){
    int y = i/width;
    int x = i%width; 
    set(x,y,edges[i]);
  }
}
//returns new pixel value in grey scale
int getNewPixelValue(int x, int y) {
  //modified robinson detection
  int[][] kernal = {
    {-1, -1, 1}, 
    {-1, 0, 1}, 
    {-1, 1, 1}, 
  };
  kernal[0][0]*=greyScale(get(x-1, y-1));
  kernal[0][1]*=greyScale(get(x-1, y));
  kernal[0][2]*=greyScale(get(x-1, y+1));
  kernal[1][0]*=greyScale(get(x,y-1));
  kernal[2][0]*=greyScale(get(x+1, y-1));
  kernal[2][1]*=greyScale(get(x+1, y));
  kernal[2][2]*=greyScale(get(x+1, y+1));
  kernal[1][2]*=greyScale(get(x,y+1));

  //sum pixels
  int value = 0;
  for (int[] i : kernal) {
    for (int j : i) {
      value+=j;
    }
  }
  return abs(value);
}

int greyScale(color c){
  return (int)(red(c)+green(c)+blue(c))/3;
}