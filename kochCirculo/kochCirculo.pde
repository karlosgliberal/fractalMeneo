
ArrayList<KochLine> lines  ;   // A list to keep track of all the lines
import controlP5.*;

ControlP5 cp5;

float v1 = 50, v2 = 100, v3 = 100, v4 = 100;


void setup() {
  

  
  size(1400, 700);
  background(255);
  lines = new ArrayList<KochLine>();
  PVector a   = new PVector(0, 173);
  PVector b   = new PVector(width, 173);
  PVector c   = new PVector(width/2, 173+width*cos(radians(30)));
  

  
  // Starting with additional lines
  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));
  
  for (int i = 0; i < 2; i++) {
    generate();
  }
  
      cp5 = new ControlP5(this);
  
  cp5.begin(100,100);
  cp5.addSlider("v1",0,255).linebreak();
  cp5.addSlider("v2",0,200).linebreak();
  cp5.addSlider("v3",0,300).linebreak();
  cp5.addSlider("v4",0,400);
  cp5.end();
  
  // change the caption label for controller v1 and apply styles
  cp5.getController("v1").setCaptionLabel("Background");
  style("v1");
  
  // change the caption label for controller v2 and apply styles
  cp5.getController("v2").setCaptionLabel("Ellipse A");
  style("v2");
  
  // change the caption label for controller v3 and apply styles
  cp5.getController("v3").setCaptionLabel("Ellipse B");
  style("v3");
  
  // change the caption label for controller v3 and apply styles
  cp5.getController("v4").setCaptionLabel("Ellipse C");
  style("v4");
}

void draw() {
  background(255);
  translate(350, 100);
  scale(0.4);
  for (KochLine l : lines) {
    l.display();
  }
}

void style(String theControllerName) {
  Controller c = cp5.getController(theControllerName);
  // adjust the height of the controller
  c.setHeight(15);
  
  // add some padding to the caption label background
  c.getCaptionLabel().getStyle().setPadding(4,4,3,4);
  
  // shift the caption label up by 4px
  c.getCaptionLabel().getStyle().setMargin(-4,0,0,0); 
  
  // set the background color of the caption label
  c.getCaptionLabel().setColorBackground(color(10,20,30,140));
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
