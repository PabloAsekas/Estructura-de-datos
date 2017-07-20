/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasDinamicas;

VAR
	lista, lista1, lista2, lista3, lista4: tListaDinamica;
	e: tElemento;
BEGIN
	CrearVacia(lista);
	Construir(lista, 4);
	Construir(lista, 3);
	Construir(lista, 2);
	Construir(lista, 1);
	MostrarLista(lista);
	CrearVacia(lista2);
	Construir(lista2, 9);
	Construir(lista2, 8);
	Construir(lista2, 7);
	Construir(lista2, 6);
	Construir(lista2, 5);
	READLN;
	Concatenar(lista, lista2, lista4);
	InsertarFinal(lista4, 10);
	MostrarLista(lista4);

	READLN;
END.
