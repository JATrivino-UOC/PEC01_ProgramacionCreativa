// ======================================================
// PANEL INFERIOR COMPLETO
// ======================================================

void dibujarPanelInferior() {

  dibujarSelectorDias();

  TableRow fila = obtenerDiaSeleccionado();

  float descanso = fila.getFloat("descanso");
  float trabajo = fila.getFloat("trabajo");
  float atascos = fila.getFloat("atascos");
  float personal = fila.getFloat("personal");

  String dia = fila.getString("dia");
  String tipo = fila.getString("tipo");

  dibujarDetalleDia(
    dia,
    tipo,
    descanso,
    trabajo,
    atascos,
    personal
  );

  dibujarLeyendaActividades();

  dibujarResumenSemanal();
}

void dibujarDetalleDia(
  String dia,
  String tipo,
  float descanso,
  float trabajo,
  float atascos,
  float personal
) {

  float x = 20;
  float y = 590;
  float w = 650;
  float h = 180;

  // Panel
  fill(25, 39, 50);
  stroke(70, 90, 105);
  strokeWeight(1);
  rect(x, y, w, h, 8);

  // Título
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);

  text(
    dia + " - " + tipo,
    x + 15,
    y + 22
  );


  // =====================================
  // Barra de 24 horas
  // =====================================

  float barraX = x + 20;
  float barraY = y + 48;
  float barraW = 610;
  float barraH = 35;

  float escala = barraW / 24.0;

  float actualX = barraX;


  // Descanso
  fill(colorDescanso);
  noStroke();

  rect(
    actualX,
    barraY,
    descanso * escala,
    barraH
  );

  actualX += descanso * escala;


  // Atasco
  if (atascos > 0) {

    fill(colorAtasco);

    rect(
      actualX,
      barraY,
      atascos * escala,
      barraH
    );

    actualX += atascos * escala;
  }


  // Trabajo
  fill(colorTrabajo);

  rect(
    actualX,
    barraY,
    trabajo * escala,
    barraH
  );

  actualX += trabajo * escala;


  // Personal
  fill(colorPersonal);

  rect(
    actualX,
    barraY,
    personal * escala,
    barraH
  );


  // =====================================
  // Marcas horarias
  // =====================================

  fill(220);
  textSize(12);
  textAlign(CENTER, CENTER);

  text("0:00", barraX, barraY + 55);
  text("24:00", barraX + barraW, barraY + 55);


  // =====================================
  // Datos inferiores
  // =====================================

  float iconY = y + 125;

  textSize(14);


  // DESCANSO
  fill(colorDescanso);
  ellipse(x + 55, iconY, 18, 18);

  fill(230);
  textAlign(LEFT, CENTER);

  text(
    "Descanso\n" + descanso + " h",
    x + 75,
    iconY
  );


  // TRABAJO
  fill(colorTrabajo);
  rect(x + 210, iconY - 9, 18, 18, 3);

  fill(230);

  text(
    "Trabajo\n" + trabajo + " h",
    x + 240,
    iconY
  );


  // ATASCOS
  fill(colorAtasco);
  ellipse(x + 380, iconY, 18, 18);

  fill(230);

  text(
    "Atascos\n" + atascos + " h",
    x + 400,
    iconY
  );


  // PERSONAL
  fill(colorPersonal);
  ellipse(x + 525, iconY, 18, 18);

  fill(230);

  text(
    "Tiempo personal\n" + personal + " h",
    x + 545,
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


  // Recorremos todos los días del CSV
  for (int i = 0; i < tabla.getRowCount(); i++) {

    TableRow fila = tabla.getRow(i);

    totalTrabajo += fila.getFloat("trabajo");
    totalAtascos += fila.getFloat("atascos");
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
    "Desplazamientos",
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