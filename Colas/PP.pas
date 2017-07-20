/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uColas;
VAR
	cola, cola1, cola2, cola3: tColas;
	e: tElemento;
BEGIN
	CrearVacia (cola);
	Construir (cola, 1);
	Construir (cola, 2);
	Construir (cola, 3);
	Construir (cola, 4);
	MostrarCola (cola);
	Primero (cola, e);
	WRITELN ('El primero es: ', e);
	Ultimo (cola, e);
	WRITELN ('El ultimo es: ', e);
	WRITELN ('La longitud es: ', Longitud (cola));
	WRITELN (Pertenece (cola, 90));
	CrearVacia (cola1);
	Construir (cola1, 1);
	Construir (cola1, 2);
	CrearVacia (cola2);
	Construir (cola2, 3);
	Construir (cola2, 4);
	Concatenar (cola1, cola2, cola3);
	MostrarCola (cola3);
	READLN;
END.
