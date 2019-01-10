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
public float velocidad=45;
float rotarGeneral=2;
int recursionLevel = 2;
int lineFracture = 3;
int porcentajeAleatorio = 25;
int multiplicadorlimitesVentana = 0;
float scalaVentana = 3;
IntList recursionLevelList;
color[] listacolores;
color colorDefecto;
int valorColorInit = 55;
float pendulo = 0;
boolean gui = true; 
boolean save;

boolean toggleTramaValue = false;
boolean toggleFondoValue = false;
boolean toggleRandomValue = true;
boolean toggleScalaValue = true;
boolean toggleGirosImparesValue = true;
//boolean toggleKiller = false;
boolean toggleTranslateValue = true;
boolean toggleSoloTranslateValue = true;
boolean toggleGirosConGraciaValue = false;
boolean togglePenduloValue = false;
//boolean toggleWave = false;

boolean mostrarAbout = false;
boolean simetriaX = false;
boolean simetriaY = false;

PFont exoLight;

ControlP5 cp5;
//CheckBox checkbox;
Knob rotateWorld;
Knob velocidadKnob;
Knob porcentajeAleatorioKnob;
Knob limitesVentanaKnob;
Knob scalaKnob;
RadioButton r1, r2;
Bang horia, gorria, larrosa;
public int debug = 0;
public int rotateWorldValue = 0;

Toggle toggleTrama, toggleFondo, toggleRandom, toggleScala, toggleGirosImpares, toggleTranslate, toggleSoloTranslate, toggleGirosConGracia, togglePendulo;

//textos sueltos
Textlabel notaKeys;
Textlabel notaRecarga;
int valorInit;

void setup() {
  String[] filenames = listFileNames(sketchPath("data"));
  myImageArray = new PImage[filenames.length];

  int valorInit = (valorColorInit == 55 ? 0 : valorColorInit);
  
  

  exoLight=loadFont("font/Exo2.0-Light-15.vlw");

  listacolores = new color[3];
  listacolores[0] = color(255, 196, 4); //horia
  listacolores[1] = color(252, 13, 17); //gorria
  listacolores[2] = color(253, 81, 191); //larrosa
  colorDefecto = listacolores[valorInit];

  fullScreen(P2D);

  //aquí no hace falta quitar o poner el fondo puede estar siempre, de hecho creo que no hacía nada
  //  if (!toggleTrama) {
  background(colorDefecto);
  //}

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
  Gui();
}

void movida(){
  
  valorInit = valorColorInit;
  cp5.hide();
  

}

void draw() {
  pushMatrix();
  translate(width/2, height/2);

  if (!toggleTramaValue) {
    background(colorDefecto);
  }

  rotate(radians(rotarGeneral/2));

  pushStyle();
  for (int i= 0; i < lines.size(); i++) {
    KochLine l = lines.get(i);
    l.display(i);
  }
  popStyle();

  if (frameCount % porcentajeAleatorio == 0 && toggleRandomValue) {
    moviR=1-2*int(random(-1, 2));
  } 

  movi+=10*moviR*velocidad*0.010;
  if (movi< -200 + multiplicadorlimitesVentana*40 || movi> 700 - multiplicadorlimitesVentana*40) {
    moviR=-moviR;
  }

  popMatrix();

  if (toggleFondoValue) {  
    noStroke();
    fill(colorDefecto, 20);
    rect(0, 0, width, height );
  }

  rotarGeneral += rotateWorldValue;
  if (save) {
    salvarTGA();
  }

  about();
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
    gui=!gui;
    visibilidadGUI();
  } else if (key == 's') {
    if (save ^= true) {
      if (gui==true) {
        cp5.hide();
        noCursor();
        limpiarGUI();
      }
      salvarTGA();
    } else if (gui==true) {
      visibilidadGUI();
    }
  } else if (key == 'e') {
    toggleScala.toggle();
  } else if (key == 'g') {
    toggleGirosImpares.toggle();
  } else if (key == 't') {
    toggleTrama.toggle();
  } else if (key == 'l') {
    toggleFondo.toggle();
  } else if (key == 'v') {
    toggleRandom.toggle();
  } else if (key == 'm') {
    toggleTranslate.toggle();
  } else if (key == 'r') {
    toggleSoloTranslate.toggle();
  } else if (key == 'c') {
    toggleGirosConGracia.toggle();
  } else if (key == 'p') {
    togglePendulo.toggle();
  } else if (key == 'a') {
    mostrarAbout =!mostrarAbout;
  } else if (key == ',') {
    if (velocidad < 255) {
      velocidad = velocidad+10;
    }
  } else if (key == ';') {
    if (velocidad > 0) {
      velocidad = velocidad-10;
    } 
  } else if (key == '.') {
    if (rotateWorldValue < 30) {
      rotateWorldValue = rotateWorldValue+1;
    } 
  } else if (key == ':') {
    if (rotateWorldValue > 0) {
      rotateWorldValue = rotateWorldValue-1;
    } 
  } else if (key == '-') {
    if (scalaVentana < 30) {
      scalaVentana = scalaVentana+1;
    } 
  } else if (key == '_') {
    if (scalaVentana > 0) {
      scalaVentana = scalaVentana-1;
    } 
  } else if (key == 'x') {
    simetriaX =!simetriaX;
  } else if (key == 'y') {
    simetriaY =!simetriaY;
  }
}

void visibilidadGUI() {
  if (gui==false) {
    noCursor();
    cp5.hide();
    limpiarGUI();
  } else {
    cp5.show();
    cursor();
  }
}
void limpiarGUI() {
  noStroke();
  fill(colorDefecto);
  rect(10, height-10-520-10, 270, 520+10);
}

void about() {
  if (mostrarAbout) {

    int anchoCaja = 440;
    int altoCaja = 180;

    pushMatrix();
    translate(width/2-anchoCaja/2, height/2-altoCaja/2);

    pushStyle();
    noStroke();
    fill(0, 150);
    rect(0, 0, anchoCaja, altoCaja);

    fill(255);
    textAlign(CENTER);
    textFont(exoLight);
    textSize(15);
    text("Herramienta realizada por", anchoCaja/2, 40);
    text("Karlos G. Liberal aka Patxangas y Martin Etxauri aka Txo!?", anchoCaja/2, 65);
    text("Para el proyecto MENEO de Marisa Mantxola", anchoCaja/2, 100);
    text("Licencia MIT ;D", anchoCaja/2, 150);

    popMatrix();
    popStyle();
  }
}
