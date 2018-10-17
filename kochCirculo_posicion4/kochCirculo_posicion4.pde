import controlP5.*;

ArrayList<KochLine> lines  ;   // A list to keep track of all the lines
PImage[] myImageArray = new PImage[6];

PVector centro = new PVector(0, -1);
PVector movida = new PVector(23, 45);

float movi=100;
float moviR=1;
float velocidad=1;
float rotarGeneral=0;



ControlP5 cp5;
public int myColor = color(0, 0, 0);
public int sliderValue = 0;

void setup() {
  fullScreen();
  background(255, 196, 4); //horia



  int dimension = height/2-height/20;

  lines = new ArrayList<KochLine>();
  PVector a   = new PVector(dimension*cos(radians(210)), dimension*sin(radians(210)));
  PVector b   = new PVector(dimension*cos(radians(-30)), dimension*sin(radians(-30)));
  PVector c   = new PVector(dimension*cos(radians(90)), dimension*sin(radians(90))); 

  // Starting with additional lines
  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));


  for (int i = 0; i <2; i++) {
    generate();
  }

  for (int i=0; i<myImageArray.length; i++) {
    myImageArray[i]=loadImage("data/" + str(i) + "_125.png"); // Aquí cambias el formato de las imágenes (de _250 solo hay 3)
  }

  cp5 = new ControlP5(this);
  cp5.addSlider("slider")
    .setRange(0, 20)
    .setValue(0)
    .setPosition(20, 100)
    .setSize(20, 100)
    ;
}

void draw() {


  pushMatrix();
  translate(width/2, height/2);//esto es necesario para centrar y cejar la coordenada 0,0 en el centro del canvas
  background(255, 196, 4); //horia
  rotate(radians(rotarGeneral));

  for (int i= 0; i < lines.size(); i++) {
    KochLine l = lines.get(i);
    l.display(i);
  }

  if (frameCount % 30 == 0) {//cada X frames randomiza la dirección y la velocidad del movimiento (hacia afuera o hacia adentro)
    moviR=1-2*int(random(-1, 2));
    //velocidad=random(0,2);
  }

  movi+=5*moviR*velocidad;

  if (movi<-200 || movi>700) {//si se va a pirar mucho de la pantalla cambiamos la dirección // esto provoca skratches :P
    moviR=-moviR;
  }
  popMatrix();
  rotarGeneral += sliderValue;
}

public void slider(int theColor) {
  sliderValue = theColor;
  myColor = theColor;
  println("a slider event. setting background to "+theColor);
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

  println(lines.size());
  for (int i = 0; i <lines.size(); i++) {
    KochLine l = lines.get(i);
    l.addValor(i);
  }
}

void keyPressed() {
  // default properties load/save key combinations are 
  // alt+shift+l to load properties
  // alt+shift+s to save properties
  if (key=='1') {
    cp5.saveProperties(("valoresUi.json"));
  } else if (key=='2') {
    cp5.loadProperties(("valoresUi.json"));
  } else if (key == '3') {
    cp5.hide();
  } else if (key == '4') {
    cp5.show();
  }
}
