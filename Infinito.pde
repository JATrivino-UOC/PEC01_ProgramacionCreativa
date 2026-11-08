// ======================================================
// DIBUJAR SÍMBOLO DE INFINITO CON COLORES PROPORCIONALES
// ======================================================

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


// ======================================================
// BASE OSCURA DE LA CARRETERA
// ======================================================

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


// ======================================================
// SEGMENTOS DE COLOR SEGÚN LAS HORAS
// ======================================================

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


// ======================================================
// LÍNEA CENTRAL DISCONTINUA
// ======================================================

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