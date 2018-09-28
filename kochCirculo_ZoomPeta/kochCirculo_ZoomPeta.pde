
ArrayList<KochLine> lines  ;   // A list to keep track of all the lines

PImage[] myImageArray = new PImage[3];

PVector centro = new PVector(0, -1);

int veces = 0;

void setup() {
  size(800, 800);
  frameRate(1);
  
  background(255);
  background(252, 13, 17); //gorria
  background(253, 81, 191); //larrosa
  background(255, 196, 4); //horia

  lines = new ArrayList<KochLine>();
  PVector a   = new PVector(300*cos(radians(210)), 300*sin(radians(210)));
  PVector b   = new PVector(300*cos(radians(-30)), 300*sin(radians(-30)));
  PVector c   = new PVector(300*cos(radians(90)), 300*sin(radians(90))); 

  // Starting with additional lines
  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));

  pushStyle(); 

  //puntos de refecencia de la forma total, para construirla y centrala bien
  /*  strokeWeight(10);
   stroke(0, 0, 255);
   point(centro.x, centro.y);
   stroke(255, 0, 0);
   point(a.x, a.y);
   point(b.x, b.y);
   point(c.x, c.y);
   */



  for (int i=0; i<myImageArray.length; i++) {
    myImageArray[i]=loadImage("data/" + str(i) + "_125.png"); // Aquí cambias el formato de las imágenes (de _250 solo hay 3)
  }
}

void draw() {
  //translate(width/2, height/2);//esto es necesario para centrar y cejar la coordenada 0,0 en el centro del canvas
  //  background(255);
   
   scale(4);
   
    for (int i = 0; i < veces; i++) {
    generate();
  }
  
  for (KochLine l : lines) {  
    l.display();
  }
  
  veces++;
  println(veces);
//  noLoop();
}

void generate() {
  ArrayList next = new ArrayList<KochLine>();    // Create emtpy list
  for (KochLine l : lines) {
    // Calculate 5 koch PVectors (done for us by the line object)
    PVector a = l.kochA();                 
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
    // Make line segments between all the PVectors and add them
    next.add(new KochLine(a, b));
    next.add(new KochLine(b, c));
    next.add(new KochLine(c, d));
    next.add(new KochLine(d, e));
  }
  lines = next;
}