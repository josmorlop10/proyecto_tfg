# PROYECTO TFG - GBDK2020:
Este repositorio esta compuesto por tres diferentes carpetas, según 
la plantilla recomendada en la documentacion de GBDK2020 (aunque se han hecho algunas modificaciones). Disponible en: 
 https://gbdk.org/docs/api/docs_getting_started.html#autotoc_md15

En general, el repositorio contiene todo lo necesario para la creación y compilacion de un videojuego haciendo uso del lenguaje C y la herramienta GBDK2020. Más información del contenido abajo.

## Jugabilidad

### Objetivo

Si usamos la misma nomenclatura que dentro del código, el juego está compuesto por varias entidades. Tenemos la "salida", "destino", "personaje", "bloques", "objetos", "eventos". 

OBJETIVO: Que el personaje llegue a la casilla de destino, o final.

Al presionar el boton Start, el personaje saldrá desde la "salida", andando en alguna dirección. 

Previamente (antes de pulsar start) el jugador tendrá la capacidad de poner "Bloques". Los bloques cambiarán propiedades del personaje. Por ejemplo, cambio de dirección. El objetivo del jugador será trazar un recorrido para el personaje, de salida a destino. Durante ese recorrido el personaje podrá interactuar con cosas que haya previamente en el mapa, diferenciados en objetos y eventos. Los objetos son elementos que al interaccionar con el personaje, se borrarán. Elementos por así decirlo, de un solo uso. Los eventos serán persistentes. Por ejemplo, una caida, o un muro.

### Controles

Pulsar flechas para mover el "seleccionador"
Pulsar "A" (en ordenador "S") para poner bloques.
Pulsar "B" (en ordenador "A") para eliminar bloques.
Pulsar Select (en ordenador, "Shift") para cambiar de bloque seleccionado
Pulsar Start (en ordenador, "Intro") para empezar el juego.


## Como compilar el código y probar el juego

Para compilar el codigo se debe modificar el makefile y cambiar el valor de la constante GBDK_HOME segun donde quede instalada la herramienta en tu computador. Yo uso el wsl para hacerlo con comandos de Ubuntu. Te vas al directorio del proyecto concreto y se corre el comando  ` make `

Para probar los ejecutables .gb, estoy usando la herramienta de emulacion gbg. ( https://bgb.bircd.org/ ). El archivo .gb se encuentra en la carpeta  ` obj  `. Tiene por nombre  `Example.gb` 

## Herramientas usadas.
GBDK-2020.
Para graficos uso GameBoyTileDesigner y GameBoyMapBuilder.
Emulador bgb
Makefile
Como IDE Visual
