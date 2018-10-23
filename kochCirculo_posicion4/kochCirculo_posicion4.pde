import controlP5.*;

ArrayList<KochLine> lines;   
//Cuantas imágenes relacionado con java.file
PImage[] myImageArray = new PImage[6];
PVector centro = new PVector(0, -1);
float movi=100;
float moviR=1;
float velocidad=10;
float rotarGeneral=2;
int recursionLevel = 2;
int lineFracture = 3;
int porcentajeAleatorio = 10;
IntList recursionLevelList;

boolean toggleTrama = true;
boolean toggleFondo = true;
boolean toggleRandom = true;

ControlP5 cp5;
CheckBox checkbox;
Knob rotateWorld;
Knob velocidadKnob;
Knob porcentajeAleatorioKnob;
RadioButton r1, r2;
public int debug = 0;
public int rotateWorldValue = 0;


void setup() {
  fullScreen();
  if(!toggleTrama){
    background(255, 196, 4); //horia
  }
  
  frameRate(25);
  int dimensions = height/2-height/20;
  lines = new ArrayList<KochLine>();
  recursionLevelList = new IntList();


  PVector a   = new PVector(dimensions*cos(radians(210)), dimensions*sin(radians(210)));
  PVector b   = new PVector(dimensions*cos(radians(-30)), dimensions*sin(radians(-30)));
  PVector c   = new PVector(dimensions*cos(radians(90)), dimensions*sin(radians(90))); 

  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));

  for (int i = 0; i < recursionLevel; i++) {
    generate();
  }

  recursionLevel();
  println(recursionLevelList);

  for (int i=0; i<myImageArray.length; i++) {
    // Aquí cambias el formato de las imágenes (de _250 solo hay 3)
    myImageArray[i]=loadImage("data/" + str(i) + "_125.png");
  }

  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("g1")
    .setPosition(20, 50)
    .setWidth(400)
    .setBackgroundHeight(600)
    .setBackgroundColor(color(5, 70))
    .setLabel("Controles")
    ;

  //cp5.addSlider("rotateWorld")
  //  .setRange(0, 40)
  //  .setValue(2)
  //  .setPosition(20, 60)
  //  .setGroup(g1)
  //  .setSize(20, 100)
  //  ;

  r1 = cp5.addRadioButton("NivelRecursion")
    .setPosition(20, 20)
    .setSize(20, 20)
    .setColorForeground(color(120))
    .setItemsPerRow(5)
    .setSpacingColumn(10)
    .addItem("0", 0)
    .addItem("1", 1)
    .addItem("2", 2)
    .addItem("3", 3)
    .addItem("4", 4)
    .setLabel("Nivel recursion")
    .setGroup(g1)
    ;

  for (Toggle t : r1.getItems()) {
    t.getCaptionLabel().setColorBackground(color(25, 90));
    t.getCaptionLabel().getStyle().moveMargin(-7, 0, 0, -3);
    t.getCaptionLabel().getStyle().movePadding(7, 0, 0, 3);
    t.getCaptionLabel().getStyle().backgroundWidth = 10;
    t.getCaptionLabel().getStyle().backgroundHeight = 13;
  }

  cp5.addToggle("toggleTrama")
    .setPosition(20, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    ;

  cp5.addToggle("toggleFondo")
    .setPosition(100, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    ;
    
   cp5.addToggle("toggleRandom")
    .setPosition(180, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    ;

  velocidadKnob = cp5.addKnob("velocidadKnob")
    .setRange(0, 100)
    .setValue(2)
    .setPosition(20, 260)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(5)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("velocidad Movida");
  ;
  
    rotateWorld = cp5.addKnob("rotateWorld")
    .setRange(0, 40)
    .setValue(2)
    .setPosition(100, 260)
    .setRadius(30)
    .setNumberOfTickMarks(20)
    .setTickMarkLength(2)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Rotar el mundo");
  ;
  
    porcentajeAleatorioKnob = cp5.addKnob("porcentajeAleatorioKnob")
    .setRange(10, 100)
    .setValue(30)
    .setPosition(180, 260)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(5)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Porcentaje aleatorio");
  ;
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);

  if (!toggleTrama) {
    background(255, 196, 4);
  }

  rotate(radians(rotarGeneral));

  for (int i= 0; i < lines.size(); i++) {
    KochLine l = lines.get(i);
    l.display(i);
  }

  if (frameCount % porcentajeAleatorio == 0 && toggleRandom) {
    println("porcentaje");
    moviR=1-2*int(random(-1, 2));
    println(moviR);
  }

  movi+=10*moviR*velocidad;

  //si se va a pirar mucho de la pantalla cambiamos la dirección 
  // esto provoca skratches :P
  //Controlar con slider 
  if (movi<-200 || movi>700) {
    moviR=-moviR;
  }
  popMatrix();
  rotarGeneral += rotateWorldValue;

  if (!toggleFondo) {
    pushStyle();
    blendMode(NORMAL);
    noStroke();
    fill(255, 196, 4, 20); //horia
    rect(0, 0, width, height );
    popStyle();
  }
  //salvarJPG();
}

public void rotateWorld(int value) {
  rotateWorldValue = value;
}

public void velocidadKnob(int value) {
  println("movida");
  println(value);
  velocidad = value * 0.010;
}


public void porcentajeAleatorioKnob(int value) {
  println(value);
  porcentajeAleatorio = value;
}


public void toggleTrama(boolean value) {
  println(value);
  toggleTrama = value;
  //if (!value) {
  //  cp5.hide();
  //}
}

public void toggleFondo(boolean value) {
  println(value);
  toggleRandom = value;
}

public void toggleRandom(boolean value) {
  println("movida radom");
  toggleRandom = value;
}


void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    if (debug==1) {
      debug = 0;
    } else {
      debug = 1;
    }
    print("got an event from "+checkbox.getName()+"\t\n");
  }
  if (theEvent.isFrom(r1)) {
    for (int i=0; i<theEvent.getGroup().getArrayValue().length; i++) {
      print(int(theEvent.getGroup().getArrayValue()[i]));
    }
    println("\t "+theEvent.getValue());
    recursionLevel = (int) theEvent.getValue();
    cp5.hide();
    setup();
    cp5.show();
  }
}

void recursionLevel() {
  int linesNumbers = lines.size();
  int division = linesNumbers;

  for (int i = 0; i < recursionLevel; i++) {
    recursionLevelList.append(division);
    division = division / 4;
  }
  //Añadimos un ultimo valor para las tres lineas del principio
  recursionLevelList.append(6);
  recursionLevelList.append(3);
  recursionLevelList.reverse();

  for (int i = 0; i <= recursionLevel; i++) {
    int resto = recursionLevelList.get(i) / lineFracture;
    for (int j = 0; j < linesNumbers; j++) {
      KochLine l = lines.get(j);
      if (resto == 0) {
        l.addRecursionValue(1);
      } else {
        if (j % resto == 0) {
          l.addRecursionValue(i+1);
        }
      }
    }
  }
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
    cp5.getProperties().setFormat(ControlP5.SERIALIZED);
    cp5.saveProperties(("valoresUi.ser"));
  } else if (key=='2') {
    cp5.loadProperties(("valoresUi.ser"));
  } else if (key == '3') {
    cp5.hide();
  } else if (key == '4') {
    cp5.show();
  }
}
