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