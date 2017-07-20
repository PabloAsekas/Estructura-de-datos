/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasInsercionFinal;
VAR
	lista, lista2, lista3: tListasInsercionFinal;
	e: tElemento;
BEGIN
	CrearVacia(lista);
	CrearVacia(lista2);
	Construir(lista, 2);
	Construir(lista, 3);
	Construir(lista, 4);
	Construir(lista2, 5);
	Construir(lista2, 6);
	Construir(lista2, 7);
	Concatenar(lista, lista2, lista3);
	MostrarLista(lista3);
	WRITELN ('Pertenece el 2: ', Pertenece(lista3, 9));
	READLN;
END.
