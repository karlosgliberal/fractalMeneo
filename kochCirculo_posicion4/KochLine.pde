class KochLine {
  PVector start;
  PVector end;
  int recursionValue;

  KochLine(PVector a, PVector b) {
    start = a.copy();
    end = b.copy();
    recursionValue = 0;
  }
  
  //Añade el valor de recursión
  void addValor(int recursionLevel){
    recursionValue = recursionLevel;
  }

 
  void display(int lineNum) {
    pushMatrix();
    translate(start.x, start.y);

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
    scale( recursionValue*0.5);
    
    pushMatrix();
    translate(0, movi);
    //esto aquí en vez de en las coordenadas de la imagen para que el rotate que viene debajo sea sobre el eje de la imagen.
    //en las coordenadas de la imagen, si ponemos 2movi" también en el X conseguimos una rotación en espiral, mola
    //si ponemos solo en el X es más como un baliecito, que combinado 

    //esto si en vez de estar aquí, está por encima del translate anterior, gira con radio "movie" y también es interesante
    rotate(radians(movi));

    //  tint(255, 180); //esto para transparentar las imágenes
    //meto esto y quito el maravillo hack :P y hago sitio limpio para el movimiento.
    imageMode(CENTER); 
    //le he quitado las medidas y coge las propias del archivo
    image(myImageArray[lineNum % myImageArray.length], 0, 0); 

    popMatrix();
    popMatrix();

    stroke(0, 255);
    strokeWeight(3);
    //line(start.x, start.y, end.x, end.y);
    //textSize(24);
    //text(valor, start.x, end.y);
  }

  PVector kochA() {
    return start.copy();
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
    PVector a = start.copy(); // Start at the beginning

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
    return end.copy();
  }
}

public void rotate(PVector v, float theta) {
  float xTemp = v.x;
  // Might need to check for rounding errors like with angleBetween function?
  v.x = v.x*PApplet.cos(theta) - v.y*PApplet.sin(theta);
  v.y = xTemp*PApplet.sin(theta) + v.y*PApplet.cos(theta);
}
