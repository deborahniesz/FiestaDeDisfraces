# Fiesta - Noviembre 2017

## Contenido a evaluar

```
● Composición / Correcta delegación
● Polimorfismo
● Herencia / Redefinición
● Template method o correcto uso de super
● Composite / Strategy
● Diferenciar clases e instancias
● Manejo de errores
```
## Enunciado

Un amigo nuestro nos pidió que generemos una
aplicación para ayudarlo en la organización de
fiestas de disfraces.
Todo comienza cuando se celebra una fiesta, que ocurre en un lugar (ej: casa de
Tina), una fecha, y hay una serie de invitados. Cada invitado asiste con un disfraz,
aunque en cualquier momento puede cambiarlo por otro. Todos los disfraces tienen
un nombre: “Media naranja”, “Político de turno”, etc. y sabemos la fecha en la que fue
confeccionado.

## Puntuación de un disfraz

Queremos saber cuántos puntos tiene un disfraz, sabiendo que puede ser una
combinación de las siguientes características:
● **graciosos: ​** está determinado por el nivel de gracia que tiene el disfraz (va de 1
a 10) y lo multiplican por 3 si el que lo lleva tiene más de 50 años.
● **tobaras:​** sabemos qué día lo compraron, un disfraz comprado 2 ó más días
antes del día de la fiesta vale 5 puntos, o 3 en caso contrario.
● **caretas:​** la careta simula un personaje real, y el valor es el que tiene dicho
personaje (por ejemplo, el de Mickey Mouse vale 8, mientras que el de Oso
Carolina vale 6).
Como dijimos antes es posible que un disfraz sea gracioso, tobara y careta, solo
careta, gracioso y tobara, no tener ninguna característica, ser gracioso, etc. (es una
combinación).
Además, un buen disfraz se luce con una buena actitud! Una persona tiene buena
actitud si se siente cómoda. En caso afirmativo, se le suman 20 puntos al valor total
de la puntuación, sino no se le suma nada. A continuación se explica cómo saber si
una persona se siente cómoda.


## Comodidad de una persona

Las personas pueden ser varones, mujeres o no aclarar (porque a fin de cuentas qué
importa). Además, los disfraces pueden ser estereotípicamente masculinos,
femeninos o neutros.
● Los varones y mujeres sólo se sienten cómodos con disfraces masculinos y
femeninos respectivamente.
● Quienes no aclaran se sienten cómodos en cualquier tipo de disfraz (son
almas libres) pero reciben un boost de confianza si encima el disfraz es
neutro (comodidad 25).
¡Pero ojo! Pueden haber personas de género fluido. Es decir, no importa con qué
género nació la persona, puede decidir ser otro en cualquier momento.

## Satisfecho o le devolvemos su traje

Todas las personas suelen estar conformes con un traje mayor a 10 puntos, y...
● ...los caprichosos quieren además que su traje tenga un nombre que tenga
una cantidad par de letras
● ...los pretenciosos quieren que el traje esté hecho hace menos de 30 días
● ...los numerólogos quieren que el traje no sólo sea mayor a 10 puntos sino
también que el puntaje sea exactamente una cifra que ellos determinan (por
ejemplo: 15, pero ese número puede variar).
Según nuestro amigo “las personas no cambian”, así que no le interesa que una
persona caprichosa pueda luego ser pretenciosa.

## Requerimientos

1. Determinar el puntaje de un disfraz.
2. Saber si una fiesta es un bodrio, esto ocurre cuando todos los asistentes
    están disconformes con su disfraz.
3. Saber cuál es el mejor disfraz de la fiesta (el que más puntos tiene).
4. Dada una fiesta y dos asistentes, queremos saber si pueden intercambiar
    trajes: esto se da si
       a. ambos están en la fiesta
       b. alguno de los dos está disconforme con su traje
       c. y cambiando el traje los dos pasan a estar conformes
5. Queremos agregar un asistente a una fiesta. Para eso debe cumplirse:
    a. el asistente debe tener un disfraz
    b. el asistente no debe estar ya cargado
6. Además queremos definir una “fiesta inolvidable”, una fiesta específica única
    e irrepetible que considera además que todo asistente
       a. debe ser sexy
       b. y debe estar conforme con su disfraz


7. Realizar el diagrama estático de la solución general.


