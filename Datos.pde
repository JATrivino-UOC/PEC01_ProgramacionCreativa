Table tabla;


// ======================================================
// CARGAR DATOS
// ======================================================

void cargarDatos() {

  tabla = loadTable("datos_semana.csv", "header");

  if (tabla == null || tabla.getRowCount() == 0) {
    println("ERROR: No se ha podido cargar datos_semana.csv");
    exit();
  }

  println("Datos cargados correctamente");
}


// ======================================================
// OBTENER FILA DEL DÍA SELECCIONADO
// ======================================================

TableRow obtenerDiaSeleccionado() {
  return tabla.getRow(diaSeleccionado);
}

float[] obtenerDatosAcumulados() {

  float descanso = 0;
  float atascoIda = 0;
  float trabajo = 0;
  float atascoVuelta = 0;
  float personal = 0;

  // Sumamos desde el lunes hasta el día seleccionado
  for (int i = 0; i <= diaSeleccionado; i++) {

    TableRow fila = tabla.getRow(i);

    descanso += fila.getFloat("descanso");
    atascoIda += fila.getFloat("atasco_ida");
    trabajo += fila.getFloat("trabajo");
    atascoVuelta += fila.getFloat("atasco_vuelta");
    personal += fila.getFloat("personal");
  }

  return new float[] {
    descanso,
    atascoIda,
    trabajo,
    atascoVuelta,
    personal
  };
}