// ======================================================
// TÍTULO
// ======================================================

void dibujarTitulo(
  String dia,
  String tipo
) {

  fill(30);
  textAlign(CENTER, CENTER);

  // Título principal
  textFont(fuenteTitulo);
  textSize(42);

  text(
    "MI SEMANA EN BUCLE",
    width / 2,
    55
  );

// Volvemos a la fuente normal
textFont(fuenteNormal);


  // Modo acumulado
  if (tipo.equals("Acumulado")) {

    // Rango de días
    textSize(22);

    text(
      dia,
      width / 2,
      100
    );

    // Texto secundario
    textSize(15);

    text(
      "Acumulado",
      width / 2,
      125
    );

  } else {

    // Modo diario
    textSize(22);

    text(
      dia + " · " + tipo,
      width / 2,
      100
    );
  }
}


// ======================================================
// BARRA DE 24 HORAS
// ======================================================

void dibujarBarraDia(
  float descanso,
  float trabajo,
  float atascos,
  float personal
) {

  float escala =
    barraAncho / 24.0;

  float x = barraX;


  // ---------------------------
  // Descanso
  // ---------------------------

  fill(colorDescanso);
  noStroke();

  rect(
    x,
    barraY,
    descanso * escala,
    barraAlto
  );

  x += descanso * escala;


  // ---------------------------
  // Atascos
  // ---------------------------

  if (atascos > 0) {

    fill(colorAtasco);

    rect(
      x,
      barraY,
      atascos * escala,
      barraAlto
    );

    x += atascos * escala;
  }


  // ---------------------------
  // Trabajo
  // ---------------------------

  fill(colorTrabajo);

  rect(
    x,
    barraY,
    trabajo * escala,
    barraAlto
  );

  x += trabajo * escala;


  // ---------------------------
  // Tiempo personal
  // ---------------------------

  fill(colorPersonal);

  rect(
    x,
    barraY,
    personal * escala,
    barraAlto
  );


  // ---------------------------
  // Horas inicio / fin
  // ---------------------------

  fill(40);

  textSize(16);

  text(
    "0 h",
    barraX,
    barraY + 80
  );

  text(
    "24 h",
    barraX + barraAncho,
    barraY + 80
  );
}


// ======================================================
// LEYENDA
// ======================================================

void dibujarLeyenda(
  float descanso,
  float trabajo,
  float atascos,
  float personal
) {

  float y = 685;

  textSize(18);


  // Descanso

  fill(colorDescanso);
  ellipse(220, y, 25, 25);

  fill(40);
  text(
    "Descanso: "
    + descanso
    + " h",
    320,
    y
  );


  // Trabajo

  fill(colorTrabajo);
  ellipse(460, y, 25, 25);

  fill(40);
  text(
    "Trabajo: "
    + trabajo
    + " h",
    560,
    y
  );


  // Atascos

  fill(colorAtasco);
  ellipse(700, y, 25, 25);

  fill(40);
  text(
    "Atascos: "
    + atascos
    + " h",
    800,
    y
  );


  // Tiempo personal

  fill(colorPersonal);
  ellipse(940, y, 25, 25);

  fill(40);
  text(
    "Personal: "
    + personal
    + " h",
    1040,
    y
  );
}