// ======================================================
// VISUALIZACIÓN DEL SÍMBOLO DE INFINITO
// ======================================================
// Este archivo contiene las funciones encargadas de dibujar
// el símbolo de infinito y de representar sobre él la
// distribución proporcional del tiempo mediante colores.
// ======================================================


// ------------------------------------------------------
// DIBUJO PRINCIPAL DEL INFINITO
// ------------------------------------------------------
// Coordina el dibujo de la base, los segmentos coloreados
// y la línea central del símbolo.

void dibujarInfinito(
  float descanso,
  float atascoIda,
  float trabajo,
  float atascoVuelta,
  float personal
) {

  dibujarBaseCarretera();

  dibujarSegmentosColoreados(
    descanso,
    atascoIda,
    trabajo,
    atascoVuelta,
    personal
  );

  dibujarLineaCentral();
}


// ------------------------------------------------------
// BASE DEL SÍMBOLO
// ------------------------------------------------------
// Dibuja el recorrido completo del infinito utilizando
// el color base de la carretera.

void dibujarBaseCarretera() {

  noFill();
  stroke(colorCarretera);
  strokeWeight(72);

  beginShape();

  for (float t = 0; t <= TWO_PI; t += 0.01) {

    float x = width/2 + infinitoAncho * sin(t);
    float y = infinitoY + infinitoAlto * sin(t) * cos(t);

    vertex(x, y);
  }

  endShape();
}


// ------------------------------------------------------
// SEGMENTOS PROPORCIONALES
// ------------------------------------------------------
// Calcula qué proporción del recorrido corresponde a cada
// actividad y colorea el símbolo según esos valores.
//
// En modo diario, el recorrido representa 24 horas.
// En modo acumulado, el recorrido completo representa
// las 120 horas de los cinco días laborables.

void dibujarSegmentosColoreados(
  float descanso,
  float atascoIda,
  float trabajo,
  float atascoVuelta,
  float personal
) {

  float totalHoras =
    descanso +
    atascoIda +
    trabajo +
    atascoVuelta +
    personal;

  float escalaHoras;

  if (modoAcumulado) {
    escalaHoras = 120.0;
  } else {
    escalaHoras = totalHoras;
  }

  float pDescanso = descanso / escalaHoras;
  float pAtascoIda = atascoIda / escalaHoras;
  float pTrabajo = trabajo / escalaHoras;
  float pAtascoVuelta = atascoVuelta / escalaHoras;
  float pPersonal = personal / escalaHoras;

  float limite1 = pDescanso;
  float limite2 = limite1 + pAtascoIda;
  float limite3 = limite2 + pTrabajo;
  float limite4 = limite3 + pAtascoVuelta;
  float limite5 = limite4 + pPersonal;

  noFill();
  strokeWeight(56);

  float paso = 0.01;

  for (float t = 0; t < TWO_PI; t += paso) {

    float progreso = t / TWO_PI;

    color c;

    if (progreso < limite5) {

      if (progreso < limite1)
        c = colorDescanso;

      else if (progreso < limite2)
        c = colorAtasco;

      else if (progreso < limite3)
        c = colorTrabajo;

      else if (progreso < limite4)
        c = colorAtasco;

      else
        c = colorPersonal;


      stroke(c);

      float x1 =
        width/2 + infinitoAncho * sin(t);

      float y1 =
        infinitoY +
        infinitoAlto * sin(t) * cos(t);


      float x2 =
        width/2 + infinitoAncho * sin(t + paso);

      float y2 =
        infinitoY +
        infinitoAlto *
        sin(t + paso) *
        cos(t + paso);


      line(
        x1,
        y1,
        x2,
        y2
      );
    }
  }
}


// ======================================================
// COLOR SEGÚN POSICIÓN DENTRO DE LAS 24 HORAS
// ======================================================

color colorSegunProgreso(
  float progreso,
  float limite1,
  float limite2,
  float limite3,
  float limite4
) {

  if (progreso < limite1) {
    return colorDescanso;
  } else if (progreso < limite2) {
    return colorAtasco;
  } else if (progreso < limite3) {
    return colorTrabajo;
  } else {
    return colorPersonal;
  }
}


// ------------------------------------------------------
// LÍNEA CENTRAL
// ------------------------------------------------------
// Dibuja una línea discontinua sobre el recorrido para
// reforzar visualmente la apariencia de carretera.

void dibujarLineaCentral() {

  stroke(255);
  strokeWeight(3);

  float paso = 0.08;

  for (float t = 0; t < TWO_PI; t += paso * 2) {

    float x1 = width/2 + infinitoAncho * sin(t);
    float y1 = infinitoY + infinitoAlto * sin(t) * cos(t);

    float x2 = width/2 + infinitoAncho * sin(t + paso);
    float y2 = infinitoY + infinitoAlto * sin(t + paso) * cos(t + paso);

    line(x1, y1, x2, y2);
  }
}