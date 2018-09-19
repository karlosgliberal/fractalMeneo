
ArrayList<KochLine> lines  ;   // A list to keep track of all the lines

void setup() {
  size(800, 800);
  background(255);
  lines = new ArrayList<KochLine>();
  PVector a   = new PVector(150, 150);
  PVector b   = new PVector(width-150, 150);
  PVector c   = new PVector(width/2, width*cos(radians(30)));
  
  // Starting with additional lines
  lines.add(new KochLine(a, b));
  lines.add(new KochLine(b, c));
  lines.add(new KochLine(c, a));
  
  for (int i = 0; i < 2; i++) {
    generate();
  }
}

void draw() {
  background(255);
  for (KochLine l : lines) {
    l.display();
  }
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
