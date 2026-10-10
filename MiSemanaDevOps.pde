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

  // Obtenemos el día actualmente seleccionado
  TableRow fila = obtenerDiaSeleccionado();

  String dia = fila.getString("dia");
  String tipo = fila.getString("tipo");

  float descanso = fila.getFloat("descanso");
  float trabajo = fila.getFloat("trabajo");
  float atascos = fila.getFloat("atascos");
  float personal = fila.getFloat("personal");

  dibujarTitulo(dia, tipo);

 dibujarInfinito(descanso, trabajo, atascos, personal);

 dibujarPanelInferior();
}

void mousePressed() {
  comprobarSeleccionDia();
}