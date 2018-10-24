import controlP5.*;
import java.io.File;

File folder;
String [] filenames;

ArrayList<KochLine> lines;   
//Cuantas imágenes relacionado con java.file
PImage[] myImageArray;
PVector centro = new PVector(0, -1);
float movi=100;
float moviR=1;
float velocidad=10;
float rotarGeneral=2;
int recursionLevel = 2;
int lineFracture = 3;
int porcentajeAleatorio = 10;
int multiplicadorlimitesVentana = 1;
float scalaVentana = 0.4;
IntList recursionLevelList;
color[] listacolores;
color colorDefecto;
int colorValorArray = 55;
boolean gui; 

boolean toggleTrama = true;
boolean toggleFondo = true;
boolean toggleRandom = false;
boolean toggleScala = true;
boolean toggleGirosImpares = true;
boolean toggleKiller = false;

ControlP5 cp5;
CheckBox checkbox;
Knob rotateWorld;
Knob velocidadKnob;
Knob porcentajeAleatorioKnob;
Knob limitesVentanaKnob;
Knob scalaKnob;
RadioButton r1, r2;
Bang horia, gorria, larrosa;
public int debug = 0;
public int rotateWorldValue = 0;


void setup() {
  
  int movidass = (colorValorArray == 55 ? 0 : colorValorArray);
  
  listacolores = new color[3];
  listacolores[0] = color(255, 196, 4); //horia
  listacolores[1] = color(252, 13, 17); //gorria
  listacolores[2] = color(253, 81, 191); //larrosa
  colorDefecto = listacolores[movidass];

  //listFileNames
  String[] filenames = listFileNames(sketchPath("data"));
  myImageArray = new PImage[filenames.length];

  fullScreen();
  if (!toggleTrama) {
    background(colorDefecto);
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

  for (int i=0; i<myImageArray.length; i++) {

    myImageArray[i]=loadImage("data/" + filenames[i]);
  }

  cp5 = new ControlP5(this);
  Group g1 = cp5.addGroup("g1")
    .setPosition(10, 490)
    .setWidth(260)
    .setBackgroundHeight(400)
    .setBackgroundColor(color(5, 70))
    .setLabel("Controles")
    ;

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
  };


  gorria = cp5.addBang("gorria")
    .setPosition(60, 250)
    .setSize(20, 20)
    .setValue(1)
    .setColorForeground(listacolores[1])
    .setGroup(g1)
    .setLabel("Gorria")
    ;

  larrosa = cp5.addBang("larrosa")
    .setPosition(100, 250)
    .setSize(20, 20)
    .setValue(2)
    .setColorForeground(listacolores[2])
    .setGroup(g1)
    .setLabel("Larrosa")
    ;

  horia = cp5.addBang("horia")
    .setPosition(20, 250)
    .setSize(20, 20)
    .setValue(0)
    //.setTriggerEvent(Bang.RELEASE)
    .setColorForeground(listacolores[0])
    .setGroup(g1)
    .setLabel("Horia")
    ;

  //revisar no esta funcionando bien
  limitesVentanaKnob = cp5.addKnob("limitesVentanaKnob")
    .setRange(1, 10)
    .setValue(0)
    .setPosition(20, 60)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(1)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Limite ventanas");
  ;

  scalaKnob = cp5.addKnob("scalaKnob")
    .setRange(1, 10)
    .setValue(4)
    .setPosition(100, 60)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(1)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Multiplicador scala");
  ;


  velocidadKnob = cp5.addKnob("velocidadKnob")
    .setRange(0, 100)
    .setValue(2)
    .setPosition(20, 160)
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
    .setValue(0)
    .setPosition(100, 160)
    .setRadius(30)
    .setNumberOfTickMarks(20)
    .setTickMarkLength(2)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Rotar el mundo");
  ;

  porcentajeAleatorioKnob = cp5.addKnob("porcentajeAleatorioKnob")
    .setRange(1, 100)
    .setValue(30)
    .setPosition(180, 160)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(5)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Porcentaje aleatorio");
  ;

  //Toogles 
  cp5.addToggle("toggleScala")
    .setPosition(20, 300)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Scala");
  ;

  cp5.addToggle("toggleGirosImpares")
    .setPosition(100, 300)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Giros impares");
  ;

  cp5.addToggle("toggleKiller")
    .setPosition(180, 300)
    .setSize(50, 20)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Modo Killer");
  ;

  cp5.addToggle("toggleTrama")
    .setPosition(20, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Trama");
  ;

  cp5.addToggle("toggleFondo")
    .setPosition(100, 350)
    .setSize(50, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Fondo");
  ;

  cp5.addToggle("toggleRandom")
    .setPosition(180, 350)
    .setSize(50, 20)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Quitar Random");
  ;
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);

  if (!toggleTrama) {
    background(colorDefecto);
  }

  rotate(radians(rotarGeneral));

  for (int i= 0; i < lines.size(); i++) {
    KochLine l = lines.get(i);
    l.display(i);
  }

  if (frameCount % porcentajeAleatorio == 0 && toggleRandom) {
    moviR=1-2*int(random(-1, 2));
  } 

  movi+=10*moviR*velocidad;
  if (movi<-200 / multiplicadorlimitesVentana || movi>700 / multiplicadorlimitesVentana) {
    moviR=-moviR;
  }
  popMatrix();
  rotarGeneral += rotateWorldValue;


  if (toggleFondo) {
    pushStyle();
    blendMode(NORMAL);
    noStroke();
    fill(255, 196, 4, 20); //horia
    rect(0, 0, width, height );
    popStyle();
  }
  //salvarJPG();
}

//function to get all files in the data folder
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();

    StringList filelist = new StringList();

    for (String s : names) {
      if (!s.contains("DS_Store")) {
        filelist.append(s);
      }
    }
    return filelist.array();
  } else {
    // if it's not a directory
    return null;
  }
}


public void limitesVentanaKnob(int value) {
  multiplicadorlimitesVentana = value;
}

public void scalaKnob(int value) { 
  scalaVentana = value * 0.1;
}

public void rotateWorld(int value) {
  rotateWorldValue = value;
}

public void velocidadKnob(int value) {
  velocidad = value * 0.010;
}

public void porcentajeAleatorioKnob(int value) {
  porcentajeAleatorio = value;
}

public void toggleScala(boolean value) {
  toggleScala = value;
}

public void toggleGirosImpares(boolean value) {
  toggleGirosImpares = value;
}

public void toggleKiller(boolean value) {
  toggleKiller = value;
}

public void toggleTrama(boolean value) {
  toggleTrama = value;
  //if (!value) {
  //  cp5.hide();
  //}
}

public void toggleFondo(boolean value) {
  toggleFondo = value;
}

public void toggleRandom(boolean value) {
  toggleRandom = value;
}

//public void horia(int value) {
//  colorDefecto = listacolores[value];
//}

//public void gorria(int value) {
//  colorDefecto = listacolores[value];
//}

//public void larrosa(int value) {
//  cambioFondo(value);
//}

//void cambioFondo(int value) {
//  println("cambio");
//  colorDefecto = listacolores[value];
//  if (!toggleFondo) {
//    println("cambio dentro");
//    //setup();
//  }
//}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    recursionLevel = (int) theEvent.getValue();
    cp5.hide();
    setup();
    cp5.show();
  }
  if (theEvent.isFrom(horia)) {
    int movida = (int) theEvent.getValue();
    colorDefecto = listacolores[movida];
    if (!toggleFondo) {
      setup();
    }
  }
  if (theEvent.isFrom(gorria)) {
    int movida = (int) theEvent.getValue();
    println(movida);
    colorDefecto = listacolores[movida];
    if (!toggleFondo) {
      setup();
    }
  }  
  if (theEvent.isFrom(larrosa)) {

    int movida = (int) theEvent.getValue();
    colorValorArray = movida;
    colorDefecto = listacolores[movida];
    if (!toggleFondo) {
      setup();
    }
  }

  //if(theEvent.isFrom()){
  //  println(theEvent.getValue());
  //}
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
    println("load");
    cp5.getProperties().setFormat(ControlP5.SERIALIZED);
    cp5.loadProperties(("valoresUi.ser"));
  } else if (key == '3') {
    if (gui ^= true) {
      noCursor();
      cp5.hide();
    } else {
      cp5.show();
      cursor();
    }
  }
}
