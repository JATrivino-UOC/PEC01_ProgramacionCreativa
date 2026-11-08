// ======================================================
// GESTIÓN DE DATOS
// ======================================================
// Este archivo se encarga de cargar los datos externos
// desde el archivo CSV y de proporcionar las funciones
// necesarias para consultar los datos diarios y acumulados.
// ======================================================

Table tabla;


// ------------------------------------------------------
// CARGA DE DATOS
// ------------------------------------------------------
// Importa el archivo CSV mediante loadTable() utilizando
// la primera fila como cabecera de las columnas.

void cargarDatos() {

  tabla = loadTable("datos_semana.csv", "header");

  if (tabla == null || tabla.getRowCount() == 0) {
    println("ERROR: No se ha podido cargar datos_semana.csv");
    exit();
  }

  println("Datos cargados correctamente");
}


// ------------------------------------------------------
// OBTENER DÍA SELECCIONADO
// ------------------------------------------------------
// Devuelve la fila del CSV correspondiente al día que
// se encuentra seleccionado actualmente en la interfaz.

TableRow obtenerDiaSeleccionado() {
  return tabla.getRow(diaSeleccionado);
}


// ------------------------------------------------------
// CÁLCULO DE DATOS ACUMULADOS
// ------------------------------------------------------
// Suma los valores desde el lunes hasta el día seleccionado.
// Los resultados se devuelven en un array siguiendo este
// orden:
//
// 0 -> descanso
// 1 -> atasco de ida
// 2 -> trabajo
// 3 -> atasco de vuelta
// 4 -> tiempo personal

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