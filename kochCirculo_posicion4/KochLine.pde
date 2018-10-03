class KochLine {

  // Two PVectors,
  // a is the "left" PVector and 
  // b is the "right PVector
  PVector start;
  PVector end;

  KochLine(PVector a, PVector b) {
    start = a.get();
    end = b.get();
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

    //experimentos de falsear el nivel de recursión

    //con estos marco los principales reales
    if (lineNum % 16 == 0) {
      scale(1.5);
    }
    //con estos los principales de raya :P
    if (lineNum % 4 == 0 && lineNum % 8 != 0 ) {
      scale(1.5);
    }
    if (lineNum % 8 == 0 && lineNum % 16 !=0) {
      scale(1);
    }
    if (lineNum % 2 == 0 && lineNum % 4 != 0 && lineNum % 8 != 0) {
      scale(0.4);
    }
    if (lineNum % 2 == 1) {
      if (lineNum % 16 <5 || lineNum % 16 >11) {
        scale(0.75);
      }
      if (lineNum % 16 >4 && lineNum % 16 <12) {
        scale(0.75);
      }
    }
    //hasta aquí

    pushMatrix();
    translate(movi, movi);//esto aquí en vez de en las coordenadas de la imagen para que el rotate que viene debajo sea sobre el eje de la imagen.
    //en las coordenadas de la imagen, si ponemos 2movi" también en el X conseguimos una rotación en espiral, mola
    //si ponemos solo en el X es más como un baliecito, que combinado 
    
    rotate(radians(movi*random(-1.1)));//esto si en vez de estar aquí, está por encima del translate anterior, gira con radio "movie" y también es interesante

    //  tint(255, 180); //esto para transparentar las imágenes
    imageMode(CENTER); //meto esto y quito el maravillo hack :P y hago sitio limpio para el movimiento.
    image(myImageArray[lineNum % myImageArray.length], 0, 0); //le he quitado las medidas y coge las propias del archivo

    popMatrix();
    popMatrix();

    stroke(0, 255);
    strokeWeight(3);
    //  line(start.x, start.y, end.x, end.y);
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