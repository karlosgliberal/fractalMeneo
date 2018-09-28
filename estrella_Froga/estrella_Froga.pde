float r;

float Norabide;
float Norabide_R;

float graduk;

int Z = 400;
int L = 182;

float RD;
float RD2;
float seedRD;

int angulo;

Punta[] puntas = new Punta[4]; //Cuántas puntas 

PImage[] myImageArray = new PImage[4]; //Cuántas imágenes dentro de una punta

int numPuntas=4;

void setup() {  
  size(1080, 1080);
  //fullScreen();
  frameRate(25);
  //noCursor();

  angulo=360/puntas.length;

  for (int i = 0; i < puntas.length; i ++ ) { 
    puntas[i] = new Punta(i*angulo);
  }

  for (int i=0; i<myImageArray.length; i++) {
    myImageArray[i]=loadImage("data/" + str(i) + "_125.png"); // Aquí cambias el formato de las imágenes (de _250 solo hay 3)
  }
}

void draw() {
  background(255, 196, 4); //horia
  background(252, 13, 17); //gorria
  background(253, 81, 191); //larrosa
  rotarGeneral();
  r= r+0.5;


  if ((frameCount % (100) == (100)-1) /*|| (frameCount==60)*/) {
    Norabide=random(-1, 1);
    Norabide_R=random(-1, 1);
  }

  if (RD > 180 || RD < -140) {
    Norabide=-Norabide;
  }

  RD=RD+(5*Norabide);

  seedRD=seedRD+0.02;
  RD2=noise(seedRD)*5;

  if (frameCount % (1000) > 500) {
    graduk=graduk+RD2*Norabide_R;
  } else if (abs(graduk) % (360) > 2) {
    graduk=graduk+2;
  }

  for (int i = 0; i < puntas.length; i++) { 
    puntas[i].erakutsi(graduk, sin(radians(90-i*angulo))*Z/2, cos(radians(90-i*angulo))*Z/2);
  }

  // saveFrame("########.tga");
  println(frameRate);
}

class Punta {
  float S1;
  Punta(int tempS1) {
    S1 = tempS1;
  }
  void erakutsi(float S2, float ZU, float LU) {

    for (int i=0; i<myImageArray.length; i++) {
      pushMatrix();
      translate(width/2-(ZU/(1+i/2)), height/2-(LU/(1+i/2)));// Aquí este "i/2" está estableciendo la distancia entre imágenes dentro de una punta... chaaapuza! :P
      rotate(radians(S1+S2+(200*i))); 
      // noStroke();
      //   fill(50+50*i, 50*i, 0);
      // rect(0, 0, -Z/2+RD, -L/2);
      image(myImageArray[i], -Z/2+RD, -L/2);
      popMatrix();
    }
  }
}

void rotarGeneral() {
  translate(width/2, height/2);
  rotate(radians(r));
  translate(-width/2, -height/2);
}
