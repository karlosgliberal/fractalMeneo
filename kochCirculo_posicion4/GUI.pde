void Gui() {

  cp5 = new ControlP5(this);
  Group g1 = cp5.addGroup("g1")
    .setPosition(10, height-10-500)
    .setWidth(270)
    .setBackgroundHeight(500)
    .setBackgroundColor(color(5, 120))
    .setLabel("Controles")
    ;

  r1 = cp5.addRadioButton("NivelRecursion")
    .setPosition(20, 20)
    .setSize(20, 20)
    .setColorForeground(color(255, 120))
    .setColorActive(color(255, 0, 0)) //Creo que no se nos marca el activo porque vamos a setup y no le pasamos el palor a la UI
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

  limitesVentanaKnob = cp5.addKnob("limitesVentanaKnob")
    .setRange(0, 10)
    .setValue(multiplicadorlimitesVentana)
    .setPosition(20, 60)
    .setRadius(30)
    .setNumberOfTickMarks(11)
    .setTickMarkLength(2)
    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Limite ventanas");
  ;

  scalaKnob = cp5.addKnob("scalaKnob")
    .setRange(1, 10)
    .setValue(scalaVentana)
    .setPosition(100, 60)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(2)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Multiplicador scala");
  ;


  velocidadKnob = cp5.addKnob("velocidadKnob")
    .setRange(0, 150)
    .setValue(velocidad)
    .setPosition(20, 160)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(2)
    //    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("velocidad Movida");
  ;

  rotateWorld = cp5.addKnob("rotateWorld")
    .setRange(0, 30)
    .setValue(rotateWorldValue)
    .setPosition(100, 160)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(2)
    //    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Rotar el mundo");
  ;

  porcentajeAleatorioKnob = cp5.addKnob("porcentajeAleatorioKnob")
    .setRange(2, 100)
    .setValue(porcentajeAleatorio)
    .setPosition(180, 160)
    .setRadius(30)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(2)
    //    .snapToTickMarks(true)
    .setDragDirection(Knob.HORIZONTAL)
    .setGroup(g1)
    .setLabel("Ciclo Aleatorio");
  ;

  //Toogles 
  toggleScala=cp5.addToggle("toggleScala")
    .setPosition(20, 300)
    .setSize(50, 20)
    .setValue(toggleScalaValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Escala - e");
  ;

  toggleGirosImpares=cp5.addToggle("toggleGirosImpares")
    .setPosition(100, 300)
    .setSize(50, 20)
    .setValue(toggleGirosImparesValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Giro Impares - g");
  ;
  /*
  cp5.addToggle("toggleKiller")
   .setPosition(180, 300)
   .setSize(50, 20)
   .setValue(false)
   .setMode(ControlP5.SWITCH)
   .setGroup(g1)
   .setLabel("Modo Killer");
   ;*/

  toggleTrama=cp5.addToggle("toggleTrama")
    .setPosition(20, 350)
    .setSize(50, 20)
    .setValue(toggleTramaValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Trazo - t");
  ;

  toggleFondo=cp5.addToggle("toggleFondo")
    .setPosition(100, 350)
    .setSize(50, 20)
    .setValue(toggleFondoValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Limpiar Trazo - l ");
  ;

  toggleRandom=cp5.addToggle("toggleRandom")
    .setPosition(180, 300)
    .setSize(50, 20)
    .setValue(toggleRandomValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Vaiven Random - v");
  ;

  toggleTranslate=cp5.addToggle("toggleTranslate")
    .setPosition(20, 400)
    .setSize(50, 20)
    .setValue(toggleTranslateValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Translate - m");
  ;

  toggleSoloTranslate=cp5.addToggle("toggleSoloTranslate")
    .setPosition(100, 400)
    .setSize(50, 20)
    .setValue(toggleSoloTranslateValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Rotacion - r");
  ;

  toggleGirosConGracia=cp5.addToggle("toggleGirosConGracia")
    .setPosition(180, 400)
    .setSize(50, 20)
    .setValue(toggleGirosConGraciaValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Giro con Gracia - c");
  ;

  togglePendulo=cp5.addToggle("togglePendulo")
    //    .setPosition(20, 450)
    .setPosition(180, 350)
    .setSize(50, 20)
    .setValue(togglePenduloValue)
    .setMode(ControlP5.SWITCH)
    .setGroup(g1)
    .setLabel("Pendulo - p");
  ;
  /*
  cp5.addToggle("toggleWave")
   .setPosition(100, 450)
   .setSize(50, 20)
   .setValue(false)
   .setMode(ControlP5.SWITCH)
   .setGroup(g1)
   .setLabel("Wave");
   ;*/


  //Textos sueltos

  notaRecarga = cp5.addTextlabel("notaRecargaRecursion")
    .setText("*recarga")
    .setPosition(180, 25)
    .setGroup(g1)
    ;

  notaRecarga = cp5.addTextlabel("notaRegargaColores")
    .setText("*recarga")
    .setPosition(130, 255)
    .setGroup(g1)
    ;

  notaKeys = cp5.addTextlabel("notaKeysLinea1")
    .setText("1 = Guardar estado            2 = Cargar estado")
    .setPosition(10, 450)
    .setGroup(g1)
    ;

  notaKeys = cp5.addTextlabel("notaKeysLinea2")
    .setText("3 = Ocultar controles      S = Grabar Frames")
    .setPosition(10, 465)
    .setGroup(g1)
    ;
  notaKeys = cp5.addTextlabel("notaKeysLinea3")
    .setText("A = About")
    .setPosition(10, 480)
    .setGroup(g1)
    ;
}


public void limitesVentanaKnob(int value) {
  multiplicadorlimitesVentana = value;
}

public void scalaKnob(float value) { 
  scalaVentana = value;
}

public void rotateWorld(int value) {
  rotateWorldValue = value;
}

public void velocidadKnob(int value) {
  velocidad = value;
}

public void porcentajeAleatorioKnob(int value) {
  porcentajeAleatorio = value;
}

public void toggleScala(boolean value) {
  toggleScalaValue = value;
}

public void toggleGirosImpares(boolean value) {
  toggleGirosImparesValue = value;
}

/*
public void toggleKiller(boolean value) {
 toggleKiller = value;
 }*/

public void toggleTrama(boolean value) {
  toggleTramaValue = value;
}

public void toggleFondo(boolean value) {
  toggleFondoValue = value;
}

public void toggleRandom(boolean value) {
  toggleRandomValue = value;
}

public void toggleTranslate(boolean value) {
  toggleTranslateValue = value;
}

public void toggleSoloTranslate(boolean value) {
  toggleSoloTranslateValue = value;
}

public void toggleGirosConGracia(boolean value) {
  toggleGirosConGraciaValue = value;
}

public void togglePendulo(boolean value) {
  togglePenduloValue = value;
}
/*
public void toggleWave(boolean value) {
 toggleWave = value;
 }*/

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    recursionLevel = (int) theEvent.getValue();
    cp5.hide();
    setup();
    cp5.show();
  }
  if (theEvent.isFrom(horia)) {
    cambioColoresFondo((int) theEvent.getValue());
  }
  if (theEvent.isFrom(gorria)) {
    cambioColoresFondo((int) theEvent.getValue());
  }  
  if (theEvent.isFrom(larrosa)) {
    cambioColoresFondo((int) theEvent.getValue());
  }
}

void cambioColoresFondo(int valorColor) {
  //esto no hacía nada y provocaba bug, ¿por qué estaba?
  //if (!toggleFondoValue) {
  valorColorInit = valorColor;
  setup();
  //}
}