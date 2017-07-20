/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasDoblementeEnlazadas;
VAR
	lista, lista1, lista2, lista3: tListaDoblementeEnlazada;
	e: tElemento;
BEGIN
	CrearVacia (lista);
	Construir (lista, 1);
	Construir (lista, 2);
	MostrarLista (lista);
	WRITELN;
	Primero (lista, e);
	WRITELN ('El primero es: ', e);
	WRITELN;
	Resto (lista);
	MostrarLista (lista);
	WRITELN;
	Ultimo (lista, e);
	WRITELN ('El ultimo es: ', e);
	WRITELN;
	Construir (lista, 3);
	Construir (lista, 4);
	Construir (lista, 5);
	Construir (lista, 6);
	MostrarLista (lista);
	WRITELN ('La longitud es: ', Longitud (lista));
	WRITELN;
	WRITELN (Pertenece (lista, 90));
	CrearVacia (lista1);
	CrearVacia (lista2);
	Construir (lista2, 4);
	Construir (lista2, 5);
	Construir (lista2, 6);
	Concatenar (lista1, lista2, lista3);
	InsertarFinal (lista3, 3);
	Borrarelemento (lista3, 3);
	MostrarLista (lista3);
	READLN;
END.
