class KochLine {
  PVector start;
  PVector end;
  int recursionValue;

  //variables Anim
  int rotateNeg =1;

  KochLine(PVector a, PVector b) {
    start = a.copy();
    end = b.copy();
    recursionValue = 0;
  }

  //Añade el valor de recursión
  void addRecursionValue(int recursionLevel) {
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

    //a esta scale 2 variables: recursionValue ON/OFF para que todos tengan igual o no
    //y el propio multiplicador - Molaría botón para que sea 1 exactamente.
    if (!toggleScala) {
      scale(recursionValue*scalaVentana);
    }


    pushMatrix();

    //Hace que los niveles de recursión pares e impares roten hacía lados diferentes
    //Habría que poder activar y desactivar
    if (!toggleGirosImpares) {
      if (recursionValue % 2 == 0) {
        rotateNeg=-1;
      }
    }else{
      rotateNeg=1;
    }


    //Variable movi boleana alterna entre rotate y translate
    //Este rotate para que este antes o después del translate
    //Añadir un multiplicador random de dirección (ON/OFF y slider para elegir cada cuanto lo hace) *y lo mismo en el rotate de abajo ;)

    //rotate(radians(movi)*rotateNeg);

    //si hacemos "movi/recursionValue" se moverán todos igual, los mismos píxeles
    
    if(toggleTranslate){
    translate(0,movi);
    } else {
    translate(0, movi/recursionValue);
    }


    //esto si en vez de estar aquí, está por encima del translate anterior, 
    //gira con radio "movie" y también es interesante
    if (debug == 0) {
      if(toggleSoloTranslate){
        rotate(radians(movi)*rotateNeg);
      }
    }

    //slider para controlar el alfa del tint
    tint(255, 255); 

    //REPLACE si le queremos meter rollo killer que se recorta. Prescindible.
    if(!toggleKiller){
      blendMode(REPLACE);
    }
    

    imageMode(CENTER); 
    image(myImageArray[lineNum % myImageArray.length], 0, 0); 
    popMatrix();
    popMatrix();

    stroke(0, 255);
    strokeWeight(3);
    if (debug == 1) {
      line(start.x, start.y, end.x, end.y);
      textSize(24);
      text(recursionValue, start.x, start.y);
    }
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
