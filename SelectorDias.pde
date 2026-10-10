// ======================================================
// DIBUJAR SELECTOR DE DÍAS
// ======================================================

void dibujarSelectorDias() {

  float inicio =
    calcularInicioSelector();


  for (
    int i = 0;
    i < tabla.getRowCount();
    i++
  ) {

    float x =
      inicio
      + i
      * (anchoBotonDia + espacioBotones);


    // Día seleccionado

    if (i == diaSeleccionado) {

      fill(60, 120, 220);

    } else {

      fill(200);
    }


    noStroke();

    rect(
      x,
      selectorY,
      anchoBotonDia,
      38,
      8
    );


    // Texto

    if (i == diaSeleccionado) {

      fill(255);

    } else {

      fill(40);
    }


    textSize(15);

    text(
      tabla.getRow(i).getString("dia"),
      x + anchoBotonDia/2,
      selectorY + 19
    );
  }
}


// ======================================================
// COMPROBAR CLIC EN UN DÍA
// ======================================================

void comprobarSeleccionDia() {

  float inicio =
    calcularInicioSelector();


  for (
    int i = 0;
    i < tabla.getRowCount();
    i++
  ) {

    float x =
      inicio
      + i
      * (anchoBotonDia + espacioBotones);


    if (
      mouseX >= x
      && mouseX <= x + anchoBotonDia
      && mouseY >= selectorY
      && mouseY <= selectorY + 38
    ) {

      diaSeleccionado = i;
    }
  }
}


// ======================================================
// CALCULAR POSICIÓN DEL SELECTOR
// ======================================================

float calcularInicioSelector() {

  return
    (
      width
      -
      (
        tabla.getRowCount()
        * anchoBotonDia
        +
        (
          tabla.getRowCount() - 1
        )
        * espacioBotones
      )
    )
    / 2;
}