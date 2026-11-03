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
      fill(60, 120, 220);
    } else {
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