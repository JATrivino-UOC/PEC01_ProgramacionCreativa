// ======================================================
// PROGRAMA PRINCIPAL
// ======================================================
// Este archivo controla la inicialización del programa,
// la actualización de la visualización y la interacción
// principal mediante el ratón.
// ======================================================


// ------------------------------------------------------
// CONFIGURACIÓN INICIAL
// ------------------------------------------------------
// Define el tamaño de la ventana, activa el suavizado
// gráfico y carga los datos externos desde el archivo CSV.

void setup() {
  size(1200, 800);
  smooth();

  textAlign(CENTER, CENTER);

  cargarDatos();
}




// ------------------------------------------------------
// ACTUALIZACIÓN DE LA VISUALIZACIÓN
// ------------------------------------------------------
// Se ejecuta continuamente y actualiza la interfaz según
// el día seleccionado y el modo de visualización activo.
//
// En modo diario se utilizan únicamente los datos del día
// seleccionado.
//
// En modo acumulado se suman los datos desde el lunes
// hasta el día seleccionado.

void draw() {

  background(colorFondo);

  TableRow fila = obtenerDiaSeleccionado();

  String dia = fila.getString("dia");
  String tipo = fila.getString("tipo");

  float descanso;
  float atascoIda;
  float trabajo;
  float atascoVuelta;
  float personal;


  // =====================================
  // DATOS PARA EL INFINITO
  // =====================================

  if (modoAcumulado) {

    float[] acumulado = obtenerDatosAcumulados();

    descanso = acumulado[0];
    atascoIda = acumulado[1];
    trabajo = acumulado[2];
    atascoVuelta = acumulado[3];
    personal = acumulado[4];

  } else {

    descanso = fila.getFloat("descanso");
    atascoIda = fila.getFloat("atasco_ida");
    trabajo = fila.getFloat("trabajo");
    atascoVuelta = fila.getFloat("atasco_vuelta");
    personal = fila.getFloat("personal");
  }

  if (modoAcumulado) {

    String diaInicio = tabla.getRow(0).getString("dia");
    String diaFin = tabla.getRow(diaSeleccionado).getString("dia");

    dibujarTitulo(
      diaInicio + " - " + diaFin,
      "Acumulado"
    );

  } else {

    dibujarTitulo(
      dia,
      tipo
    );
  }

  dibujarInfinito(
    descanso,
    atascoIda,
    trabajo,
    atascoVuelta,
    personal
  );

  dibujarPanelInferior();
}


// ------------------------------------------------------
// INTERACCIÓN CON EL RATÓN
// ------------------------------------------------------
// Comprueba si el usuario ha pulsado el botón Acumulado
// o alguno de los botones correspondientes a los días
// de la semana.

void mousePressed() {

  comprobarBotonAcumulado();

  comprobarSeleccionDia();
}