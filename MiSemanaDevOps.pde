/*
  MI SEMANA EN BUCLE
  ------------------
  Visualización de teletrabajo frente a trabajo presencial.

  Los datos se cargan desde:
  data/datos_semana.csv
*/

void setup() {
  size(1200, 800);
  smooth();

  textAlign(CENTER, CENTER);

  cargarDatos();
}

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

void mousePressed() {

  comprobarBotonAcumulado();

  comprobarSeleccionDia();
}