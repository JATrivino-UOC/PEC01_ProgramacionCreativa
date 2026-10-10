// ======================================================
// DIBUJAR SÍMBOLO DE INFINITO CON COLORES PROPORCIONALES
// ======================================================

void dibujarInfinito(
  float descanso,
  float trabajo,
  float atascos,
  float personal
) {

  // 1. Primero dibujamos la carretera base (borde oscuro)
  dibujarBaseCarretera();

  // 2. Después pintamos el interior con colores proporcionales
  dibujarSegmentosColoreados(
    descanso,
    trabajo,
    atascos,
    personal
  );

  // 3. Por último, la línea central discontinua
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
  float trabajo,
  float atascos,
  float personal
) {

  // Convertimos las horas a proporciones de 0 a 1
  float pDescanso = descanso / 24.0;
  float pAtascos  = atascos / 24.0;
  float pTrabajo  = trabajo / 24.0;
  float pPersonal = personal / 24.0;

  // Límites acumulados
  float limite1 = pDescanso;
  float limite2 = limite1 + pAtascos;
  float limite3 = limite2 + pTrabajo;
  float limite4 = limite3 + pPersonal; // debería ser 1.0

  noFill();
  strokeWeight(56);

  // Recorremos el infinito por pequeños tramos
  float paso = 0.01;

  for (float t = 0; t < TWO_PI; t += paso) {

    // Progreso total de 0 a 1 a lo largo del símbolo
    float progreso = t / TWO_PI;

    // Elegimos color según el tramo
    stroke(colorSegunProgreso(
      progreso,
      limite1,
      limite2,
      limite3,
      limite4
    ));

    float x1 = width/2 + infinitoAncho * sin(t);
    float y1 = infinitoY + infinitoAlto * sin(t) * cos(t);

    float x2 = width/2 + infinitoAncho * sin(t + paso);
    float y2 = infinitoY + infinitoAlto * sin(t + paso) * cos(t + paso);

    line(x1, y1, x2, y2);
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