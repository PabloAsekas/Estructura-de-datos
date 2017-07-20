/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasEstaticas;
VAR
	lista, lista1, lista2, lista3, lista4, lista5, lista6: tListaEstatica;
	e, e1: integer;
BEGIN
	CrearVacia(lista6);
	Construir(lista6, 1);
	Construir(lista6, 2);
	Construir(lista6, 3);
	Construir(lista6, 4);
	Construir(lista6, 5);
	CrearVacia(lista);
	Construir(lista, 6);
	Construir(lista, 7);
	Construir(lista, 8);
	Construir(lista, 9);
	CrearVacia(lista2);
	Concatenar(lista, lista6, lista2);
	MostrarLista(lista2);

	READLN;
END.
