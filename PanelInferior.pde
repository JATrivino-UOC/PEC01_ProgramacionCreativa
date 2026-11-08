// ======================================================
// PANEL INFERIOR COMPLETO
// ======================================================

void dibujarPanelInferior() {

  dibujarBotonAcumulado();

  dibujarSelectorDias();

  TableRow fila = obtenerDiaSeleccionado();

  String dia = fila.getString("dia");
  String tipo = fila.getString("tipo");

  float descanso;
  float atascoIda;
  float trabajo;
  float atascoVuelta;
  float personal;

  float totalHoras;


  // =====================================
  // DATOS DEL PANEL INFERIOR
  // =====================================

  if (modoAcumulado) {

    float[] acumulado = obtenerDatosAcumulados();

    descanso = acumulado[0];
    atascoIda = acumulado[1];
    trabajo = acumulado[2];
    atascoVuelta = acumulado[3];
    personal = acumulado[4];

    // 24 horas por cada día incluido
    totalHoras = 24.0 * (diaSeleccionado + 1);

  } else {

    descanso = fila.getFloat("descanso");
    atascoIda = fila.getFloat("atasco_ida");
    trabajo = fila.getFloat("trabajo");
    atascoVuelta = fila.getFloat("atasco_vuelta");
    personal = fila.getFloat("personal");

    totalHoras = 24.0;
  }

  dibujarDetalleDia(
    dia,
    tipo,
    descanso,
    atascoIda,
    trabajo,
    atascoVuelta,
    personal,
    totalHoras
  );

  dibujarLeyendaActividades();

  dibujarResumenSemanal();
}

void dibujarDetalleDia(
  String dia,
  String tipo,
  float descanso,
  float atascoIda,
  float trabajo,
  float atascoVuelta,
  float personal,
  float totalHoras
) {

  // Los rectángulos se dibujan desde la esquina superior izquierda
  rectMode(CORNER);

  // =====================================
  // COMPROBACIÓN DE HORAS
  // =====================================

  float totalComprobacion =
    descanso +
    atascoIda +
    trabajo +
    atascoVuelta +
    personal;

  println(
    dia +
    " -> descanso: " + descanso +
    ", atasco ida: " + atascoIda +
    ", trabajo: " + trabajo +
    ", atasco vuelta: " + atascoVuelta +
    ", personal: " + personal +
    ", TOTAL: " + totalComprobacion
  );


  // =====================================
  // PANEL
  // =====================================

  float x = 20;
  float y = 590;
  float w = 650;
  float h = 180;

  fill(25, 39, 50);
  stroke(70, 90, 105);
  strokeWeight(1);

  rect(
    x,
    y,
    w,
    h,
    8
  );


  // =====================================
  // TÍTULO
  // =====================================

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);

  text(
    dia + " - " + tipo,
    x + 15,
    y + 22
  );


  // =====================================
  // BARRA DE 24 HORAS
  // =====================================

  float barraW = 450;
  float barraH = 35;

  // Centrada dentro del panel
  float barraX =
    x + (w - barraW) / 2;

  float barraY =
    y + 48;

  // Cada hora ocupa esta cantidad de píxeles
  float escala;

  if (modoAcumulado) {
    escala = barraW / 120.0;
  } else {
    escala = barraW / 24.0;
  }

  float actualX =
    barraX;

  noStroke();

  // Fondo completo de la barra
  fill(60, 70, 80);

  rect(
    barraX,
    barraY,
    barraW,
    barraH
  );


  // -------------------------------------
  // DESCANSO
  // -------------------------------------

  fill(colorDescanso);

  rect(
    actualX,
    barraY,
    descanso * escala,
    barraH
  );

  actualX +=
    descanso * escala;


  // -------------------------------------
  // ATASCO DE IDA
  // -------------------------------------

  if (atascoIda > 0) {

    fill(colorAtasco);

    rect(
      actualX,
      barraY,
      atascoIda * escala,
      barraH
    );

    actualX +=
      atascoIda * escala;
  }


  // -------------------------------------
  // TRABAJO
  // -------------------------------------

  fill(colorTrabajo);

  rect(
    actualX,
    barraY,
    trabajo * escala,
    barraH
  );

  actualX +=
    trabajo * escala;


  // -------------------------------------
  // ATASCO DE VUELTA
  // -------------------------------------

  if (atascoVuelta > 0) {

    fill(colorAtasco);

    rect(
      actualX,
      barraY,
      atascoVuelta * escala,
      barraH
    );

    actualX +=
      atascoVuelta * escala;
  }


  // -------------------------------------
  // TIEMPO PERSONAL
  // -------------------------------------

  fill(colorPersonal);

  rect(
    actualX,
    barraY,
    personal * escala,
    barraH
  );


  // =====================================
  // MARCAS HORARIAS
  // =====================================

  fill(220);
  textSize(12);
  textAlign(CENTER, CENTER);

  text(
    "0:00",
    barraX,
    barraY + barraH + 18
  );

  if (modoAcumulado) {

    text(
      "120 h",
      barraX + barraW,
      barraY + barraH + 18
    );

  } else {

    text(
      "24:00",
      barraX + barraW,
      barraY + barraH + 18
    );
  }

  // =====================================
  // DATOS INFERIORES
  // =====================================

  float iconY =
    y + 130;

  textSize(13);


  // DESCANSO
  fill(colorDescanso);
  ellipse(
    x + 55,
    iconY,
    18,
    18
  );

  fill(230);
  textAlign(LEFT, CENTER);

  text(
    "Descanso\n" +
    descanso + " h",
    x + 72,
    iconY
  );


  // TRABAJO
  fill(colorTrabajo);

  rect(
    x + 210,
    iconY - 9,
    18,
    18,
    3
  );

  fill(230);

  text(
    "Trabajo\n" +
    trabajo + " h",
    x + 235,
    iconY
  );


  // ATASCOS
  float totalAtascos =
    atascoIda +
    atascoVuelta;

  fill(colorAtasco);

  ellipse(
    x + 365,
    iconY,
    18,
    18
  );

  fill(230);

  text(
    "Atascos\n" +
    totalAtascos + " h",
    x + 382,
    iconY
  );


  // TIEMPO PERSONAL
  fill(colorPersonal);

  ellipse(
    x + 505,
    iconY,
    18,
    18
  );

  fill(230);

  text(
    "Personal\n" +
    personal + " h",
    x + 522,
    iconY
  );
}

void dibujarLeyendaActividades() {

  float x = 690;
  float y = 590;
  float w = 250;
  float h = 180;

  fill(25, 39, 50);
  stroke(70, 90, 105);
  rect(x, y, w, h, 8);

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);

  text(
    "Leyenda de actividades",
    x + 15,
    y + 22
  );


  dibujarElementoLeyenda(
    x + 20,
    y + 55,
    colorTrabajo,
    "Trabajo"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 85,
    colorAtasco,
    "Desplazamiento / atasco"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 115,
    colorPersonal,
    "Tiempo personal"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 145,
    colorDescanso,
    "Descanso"
  );
}

void dibujarElementoLeyenda(
  float x,
  float y,
  color c,
  String texto
) {

  noStroke();
  fill(c);

  rect(
    x,
    y - 10,
    28,
    20,
    5
  );

  fill(230);
  textSize(14);
  textAlign(LEFT, CENTER);

  text(
    texto,
    x + 40,
    y
  );
}

void dibujarResumenSemanal() {

  float x = 960;
  float y = 590;
  float w = 220;
  float h = 180;

  fill(25, 39, 50);
  stroke(70, 90, 105);
  rect(x, y, w, h, 8);

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(16);

  text(
    "Resumen semanal",
    x + 15,
    y + 22
  );


  float totalTrabajo = 0;
  float totalAtascos = 0;
  float totalPersonal = 0;
  float totalDescanso = 0;


  // Recorremos una fila por cada día
  for (TableRow fila : tabla.rows()) {

    totalTrabajo += fila.getFloat("trabajo");

    totalAtascos +=
      fila.getFloat("atasco_ida")
      +
      fila.getFloat("atasco_vuelta");

    totalPersonal += fila.getFloat("personal");

    totalDescanso += fila.getFloat("descanso");
  }


  float yTexto = y + 55;

  dibujarDatoResumen(
    "Trabajo total",
    totalTrabajo,
    x,
    yTexto
  );

  dibujarDatoResumen(
    "Atascos",
    totalAtascos,
    x,
    yTexto + 30
  );

  dibujarDatoResumen(
    "Tiempo personal",
    totalPersonal,
    x,
    yTexto + 60
  );

  dibujarDatoResumen(
    "Descanso",
    totalDescanso,
    x,
    yTexto + 90
  );
}

void dibujarDatoResumen(
  String texto,
  float valor,
  float x,
  float y
) {

  fill(220);
  textAlign(LEFT, CENTER);
  textSize(14);

  text(
    texto,
    x + 15,
    y
  );


  fill(255);
  textAlign(RIGHT, CENTER);

  text(
    nf(valor, 0, 1) + " h",
    x + 200,
    y
  );
}