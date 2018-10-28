void Gui() {

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
  if (!toggleFondo) {
    colorValorArray = valorColor;
    setup();
  }
}
