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
  String[] filenames = listFileNames(sketchPath("data"));
  myImageArray = new PImage[filenames.length];
  println(colorValorArray);
  
  int movidass = (colorValorArray == 55 ? 0 : colorValorArray);

  listacolores = new color[3];
  listacolores[0] = color(255, 196, 4); //horia
  listacolores[1] = color(252, 13, 17); //gorria
  listacolores[2] = color(253, 81, 191); //larrosa

  colorDefecto = listacolores[movidass];



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
  Gui();
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
        if (!toggleFondo) {  
    pushStyle();
    blendMode(NORMAL);
    noStroke();
    fill(255, 196, 4); //horia
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
