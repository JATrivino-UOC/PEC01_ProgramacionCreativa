// ======================================================
// CONFIGURACIÓN GENERAL
// ======================================================
// Este archivo reúne las variables globales utilizadas
// para controlar el estado de la aplicación y distintos
// parámetros visuales, como colores, tamaños y posiciones.
// ======================================================

// ------------------------------------------------------
// ESTADO DE LA APLICACIÓN
// ------------------------------------------------------
// Guarda el día actualmente seleccionado y controla si
// la visualización está en modo diario o acumulado.

// Indica si la aplicación está en modo diario o acumulado
boolean modoAcumulado = false;

// Definen la posición y tamaño del botón acumulado
float botonAcumuladoX;
float botonAcumuladoY = 475;

float botonAcumuladoW = 150;
float botonAcumuladoH = 36;

// Día seleccionado inicialmente
int diaSeleccionado = 0;

// ------------------------------------------------------
// PALETA DE COLORES
// ------------------------------------------------------
// Define los colores asociados a cada actividad y a los
// elementos principales de la interfaz.

// Fondo
color colorFondo = color(238, 242, 245);

// Colores de las actividades
color colorDescanso = color(60, 110, 170);
color colorTrabajo  = color(245, 190, 55);
color colorAtasco   = color(165, 80, 190);
color colorPersonal = color(55, 180, 105);

// Color de la carretera
color colorCarretera = color(45, 55, 65);

// Color de la línea central
color colorLineaCarretera = color(235);


// ------------------------------------------------------
// CONFIGURACIÓN DEL SÍMBOLO DE INFINITO
// ------------------------------------------------------
// Controla el tamaño y la posición del símbolo utilizado
// para representar visualmente la distribución del tiempo.

// Tamaño del símbolo infinito
float infinitoAncho = 300;
float infinitoAlto = 110;

// Posición vertical del infinito
float infinitoY = 300;


// ------------------------------------------------------
// CONFIGURACIÓN DE LA BARRA TEMPORAL
// ------------------------------------------------------
// Define la posición y dimensiones de la barra utilizada
// para representar la distribución temporal.

// Barra temporal
float barraX = 150;
float barraY = 570;
float barraAncho = 900;
float barraAlto = 55;

// ------------------------------------------------------
// CONFIGURACIÓN DE LOS BOTONES
// ------------------------------------------------------
// Define la posición y dimensiones de los botones de los
// días de la semana y del botón de modo acumulado.

// Selector de días
float selectorY = 525;
float anchoBotonDia = 150;
float espacioBotones = 20;

// ------------------------------------------------------
// ICONOS DE ACTIVIDADES
// ------------------------------------------------------
// Imágenes utilizadas como apoyo visual para identificar
// cada una de las categorías de actividad.

PImage iconoDescanso;
PImage iconoTrabajo;
PImage iconoAtasco;
PImage iconoPersonal;