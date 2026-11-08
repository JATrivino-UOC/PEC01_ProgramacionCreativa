// ======================================================
// PANEL INFERIOR
// ======================================================
// Este archivo contiene las funciones encargadas de dibujar
// la zona inferior de la interfaz: selector de días,
// barra temporal, leyenda y resumen semanal.
// ======================================================


// ------------------------------------------------------
// DIBUJO GENERAL DEL PANEL INFERIOR
// ------------------------------------------------------
// Coordina el dibujo de los distintos elementos de la zona
// inferior y obtiene los datos diarios o acumulados según
// el modo de visualización activo.

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


// ------------------------------------------------------
// DETALLE TEMPORAL
// ------------------------------------------------------
// Dibuja la barra temporal y los valores correspondientes
// al día seleccionado.
//
// En modo diario, la barra representa 24 horas.
// En modo acumulado, mantiene el mismo tamaño visual,
// pero utiliza una escala fija de 120 horas y se va
// completando progresivamente a lo largo de la semana.

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

  String textoPeriodo;

  if (modoAcumulado) {

    String diaInicio =
      tabla.getRow(0).getString("dia");

    String diaFin =
      tabla.getRow(diaSeleccionado).getString("dia");

    textoPeriodo =
      "De " + diaInicio + " a " + diaFin;

  } else {

    textoPeriodo =
      tabla.getRow(diaSeleccionado).getString("dia");
  }

  text(
    textoPeriodo,
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

  float iconY = y + 130;
  float tamIcono = 26;

  imageMode(CENTER);

  textSize(13);
  textAlign(LEFT, CENTER);


  // -------------------------------------
  // DESCANSO
  // -------------------------------------

  image(
    iconoDescanso,
    x + 55,
    iconY,
    tamIcono,
    tamIcono
  );

  fill(230);

  text(
    "Descanso\n" + nf(descanso, 0, 1) + " h",
    x + 75,
    iconY
  );


  // -------------------------------------
  // TRABAJO
  // -------------------------------------

  image(
    iconoTrabajo,
    x + 210,
    iconY,
    tamIcono,
    tamIcono
  );

  fill(230);

  text(
    "Trabajo\n" + nf(trabajo, 0, 1) + " h",
    x + 230,
    iconY
  );


  // -------------------------------------
  // ATASCOS
  // -------------------------------------

  float totalAtascos =
    atascoIda +
    atascoVuelta;

  image(
    iconoAtasco,
    x + 365,
    iconY,
    tamIcono,
    tamIcono
  );

  fill(230);

  text(
    "Atascos\n" + nf(totalAtascos, 0, 1) + " h",
    x + 385,
    iconY
  );


  // -------------------------------------
  // TIEMPO PERSONAL
  // -------------------------------------

  image(
    iconoPersonal,
    x + 505,
    iconY,
    tamIcono,
    tamIcono
  );

  fill(230);

  text(
    "Personal\n" + nf(personal, 0, 1) + " h",
    x + 525,
    iconY
  );


  // Restauramos el modo habitual
  imageMode(CORNER);
}


// ------------------------------------------------------
// LEYENDA DE ACTIVIDADES
// ------------------------------------------------------
// Muestra la relación entre los colores utilizados en la
// visualización y las distintas categorías de actividad.

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
    iconoTrabajo,
    colorTrabajo,
    "Trabajo"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 85,
    iconoAtasco,
    colorAtasco,
    "Desplazamiento / atasco"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 115,
    iconoPersonal,
    colorPersonal,
    "Tiempo personal"
  );

  dibujarElementoLeyenda(
    x + 20,
    y + 145,
    iconoDescanso,
    colorDescanso,
    "Descanso"
  );
}


// ------------------------------------------------------
// ELEMENTO INDIVIDUAL DE LA LEYENDA
// ------------------------------------------------------
// Dibuja una muestra de color junto al nombre de una
// categoría de actividad.

void dibujarElementoLeyenda(
    float x,
    float y,
    PImage icono,
    color c,
    String texto
  ) {

    float tamIcono = 26;
    float tamColor = 18;

    imageMode(CENTER);

    // Icono
    image(
      icono,
      x + tamIcono / 2,
      y,
      tamIcono,
      tamIcono
    );

    // Muestra del color asociado
    noStroke();
    fill(c);

    rect(
      x + 35,
      y - tamColor / 2,
      tamColor,
      tamColor,
      4
    );

    // Texto
    fill(230);
    textSize(14);
    textAlign(LEFT, CENTER);

    text(
      texto,
      x + 65,
      y
    );

    imageMode(CORNER);
  }


// ------------------------------------------------------
// RESUMEN SEMANAL
// ------------------------------------------------------
// Recorre todos los registros del CSV y calcula los totales
// semanales de trabajo, desplazamientos, tiempo personal
// y descanso.

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


// ------------------------------------------------------
// DATO DEL RESUMEN
// ------------------------------------------------------
// Muestra el nombre de una categoría y su valor total
// expresado en horas.

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