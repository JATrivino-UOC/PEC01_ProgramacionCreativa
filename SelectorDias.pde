// ======================================================
// DIBUJAR SELECTOR DE DÍAS
// ======================================================

void dibujarSelectorDias() {

  float inicio = calcularInicioSelector();

  for (int i = 0; i < tabla.getRowCount(); i++) {

    float x =
      inicio +
      i * (anchoBotonDia + espacioBotones);

    // Fondo botón
    if (i == diaSeleccionado) {

      // Día seleccionado
      fill(60, 120, 220);

    } else if (modoAcumulado && i < diaSeleccionado) {

      // Días anteriores incluidos en el acumulado
      fill(75, 100, 145);

    } else {

      // Días no seleccionados
      fill(60, 70, 80);
    }

    noStroke();

    rect(
      x,
      selectorY,
      anchoBotonDia,
      45,
      8
    );

    // Nombre del día
    if (i == diaSeleccionado) {
      fill(255);
    } else {
      fill(220);
    }

    textAlign(CENTER, CENTER);
    textSize(15);

    text(
  tabla.getRow(i).getString("dia"),
      x + anchoBotonDia/2,
      selectorY + 15
    );

    // Tipo de jornada
    String tipo = tabla.getRow(i).getString("tipo");

    textSize(11);

    text(
      "(" + tipo + ")",
      x + anchoBotonDia/2,
      selectorY + 32
    );
  }
}


// ======================================================
// COMPROBAR CLIC EN UN DÍA
// ======================================================

void comprobarSeleccionDia() {

  float inicio = calcularInicioSelector();

  for (int i = 0; i < tabla.getRowCount(); i++) {

    float x =
      inicio +
      i * (anchoBotonDia + espacioBotones);

    if (
      mouseX >= x &&
      mouseX <= x + anchoBotonDia &&
      mouseY >= selectorY &&
      mouseY <= selectorY + 45
    ) {

      diaSeleccionado = i;
    }
  }
}


// ======================================================
// CALCULAR POSICIÓN DEL SELECTOR
// ======================================================

float calcularInicioSelector() {

  return (
    width -
    (
      tabla.getRowCount() * anchoBotonDia +
      (tabla.getRowCount() - 1) * espacioBotones
    )
  ) / 2;
}

void dibujarBotonAcumulado() {

  // Centramos el botón horizontalmente
  botonAcumuladoX =
    width / 2 - botonAcumuladoW / 2;

  // Color según esté activado o no
  if (modoAcumulado) {
    fill(60, 120, 220);
  } else {
    fill(60, 70, 80);
  }

  noStroke();

  rect(
    botonAcumuladoX,
    botonAcumuladoY,
    botonAcumuladoW,
    botonAcumuladoH,
    8
  );

  // Texto
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(14);

  text(
    "Acumulado",
    botonAcumuladoX + botonAcumuladoW / 2,
    botonAcumuladoY + botonAcumuladoH / 2
  );
}

void comprobarBotonAcumulado() {

  if (
    mouseX >= botonAcumuladoX &&
    mouseX <= botonAcumuladoX + botonAcumuladoW &&
    mouseY >= botonAcumuladoY &&
    mouseY <= botonAcumuladoY + botonAcumuladoH
  ) {

    modoAcumulado = !modoAcumulado;
  }
}