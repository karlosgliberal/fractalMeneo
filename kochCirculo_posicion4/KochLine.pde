class KochLine {

  // Two PVectors,
  // a is the "left" PVector and 
  // b is the "right PVector
  PVector start;
  PVector end;
  int recursionLinea;

  KochLine(PVector a, PVector b, int recursion) {
    recursionLinea = recursion;
    start = a.get();
    end = b.get();
  }

  void display(int lineNum) {
    pushMatrix();
    translate(start.x, start.y);
    rotate(frameCount);

    //operaciones para buscar el ángulo
    PVector start2 = start.copy();
    start2.normalize();
    
    PVector centro2 = centro.copy();
    centro2.sub(start2);
    
    float ang=PVector.angleBetween(centro, start2);
    float angXtra;

    if (centro2.x > 0) {
      angXtra=-ang*2;
      
    } else {
      angXtra=0;
    } 
    rotate(ang+angXtra);
    tint(255, 150); //esto para transparentar las imágenes
    image(myImageArray[lineNum % myImageArray.length], -myImageArray[lineNum % myImageArray.length].width/2, -myImageArray[lineNum % myImageArray.length].height/2); //le he quitado las medidas y coge las propias del archivo
    popMatrix();

    stroke(0, 255, lineNum*10);
    strokeWeight(3);
    line(start.x, start.y, end.x, end.y);
  }

  PVector kochA() {
    return start.get();
  }

  // This is easy, just 1/3 of the way
  PVector kochB() {
    PVector v = PVector.sub(end, start);
    v.div(3);
    v.add(start);
    return v;
  }    

  // More complicated, have to use a little trig to figure out where this PVector is!
  PVector kochC() {
    PVector a = start.get(); // Start at the beginning

    PVector v = PVector.sub(end, start);
    v.div(3);
    a.add(v);  // Move to point B

    rotate(v, -radians(60)); // Rotate 60 degrees
    a.add(v);  // Move to point C

    return a;
  }    

  // Easy, just 2/3 of the way
  PVector kochD() {
    PVector v = PVector.sub(end, start);
    v.mult(2/3.0);
    v.add(start);
    return v;
  }

  PVector kochE() {
    return end.get();
  }
}

public void rotate(PVector v, float theta) {
  float xTemp = v.x;
  // Might need to check for rounding errors like with angleBetween function?
  v.x = v.x*PApplet.cos(theta) - v.y*PApplet.sin(theta);
  v.y = xTemp*PApplet.sin(theta) + v.y*PApplet.cos(theta);
}
