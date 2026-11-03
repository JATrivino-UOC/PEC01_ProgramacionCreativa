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

  float descanso = fila.getFloat("descanso");
  float atascoIda = fila.getFloat("atasco_ida");
  float trabajo = fila.getFloat("trabajo");
  float atascoVuelta = fila.getFloat("atasco_vuelta");
  float personal = fila.getFloat("personal");

  dibujarTitulo(dia, tipo);

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
  comprobarSeleccionDia();
}