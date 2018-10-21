import controlP5.*;

ArrayList<KochLine> lines;   
PImage[] myImageArray = new PImage[6];
PVector centro = new PVector(0, -1);
float movi=100;
float moviR=1;
float velocidad=1;
float rotarGeneral=0;
int recursionLevel = 2;
IntList recursionLevelArray;
ControlP5 cp5;
public int sliderValue = 0;


void setup() {
  fullScreen();
  background(255, 196, 4); //horia
  int dimension = height/2-height/20;
  lines = new ArrayList<KochLine>();
  recursionLevelArray = new IntList();

  PVector a   = new PVector(dimension*cos(radians(210)), dimension*sin(radians(210)));
  PVector b   = new PVector(dimension*cos(radians(-30)), dimension*sin(radians(-30)));
  PVector c   = new PVector(dimension*cos(radians(90)), dimension*sin(radians(90))); 

  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));

  for (int i = 0; i < recursionLevel; i++) {
    generate();
  }

  int numLines = lines.size();
  int division = numLines;

  for (int i = 0; i < recursionLevel; i++) {
    recursionLevelArray.append(division);
    division = division / 4;
  }
  
  //Añadimos un ultimo valor para las tres lineas del principio
  recursionLevelArray.append(3);
  recursionLevelArray.reverse();

  for (int i = 0; i <= recursionLevel; i++) {
    int resto = recursionLevelArray.get(i) / 4;
    println(resto);
    for (int j = 0; j < numLines; j++) {
      KochLine l = lines.get(j);
      if (resto == 0) {
        l.addValor(1);
      } else {
        if (j % resto == 0) {
          l.addValor(i+1);
        }
      }
    }
  }

  for (int i=0; i<myImageArray.length; i++) {
    // Aquí cambias el formato de las imágenes (de _250 solo hay 3)
    myImageArray[i]=loadImage("data/" + str(i) + "_125.png"); 
  }

  cp5 = new ControlP5(this);
  cp5.addSlider("slider")
    .setRange(0, 20)
    .setValue(0)
    .setPosition(20, 100)
    .setSize(20, 100);
}

void draw() {

  pushMatrix();
  //esto es necesario para centrar y cejar la coordenada 0,0 en el centro del canvas
  translate(width/2, height/2);
  background(255, 196, 4); //horia
  rotate(radians(rotarGeneral));

  for (int i= 0; i < lines.size(); i++) {
    KochLine l = lines.get(i);
    l.display(i);
  }

  //cada X frames randomiza la dirección y la velocidad 
  //del movimiento (hacia afuera o hacia adentro)
  if (frameCount % 30 == 0) {
    moviR=1-4*int(random(-1, 2));
  }

  movi+=10*moviR*velocidad;

  //si se va a pirar mucho de la pantalla cambiamos la dirección 
  // esto provoca skratches :P
  if (movi<-200 || movi>700) {
    moviR=-moviR;
  }
  popMatrix();
  rotarGeneral += sliderValue;
}

public void slider(int value) {
  sliderValue = value;
}



void generate() {
  ArrayList next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
    PVector a = l.kochA();                 
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
    next.add(new KochLine(a, b));
    next.add(new KochLine(b, c));
    next.add(new KochLine(c, d));
    next.add(new KochLine(d, e));
  }
  lines = next;
}


void keyPressed() {
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
