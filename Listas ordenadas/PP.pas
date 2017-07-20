/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasOrdenadas;
VAR
	lista, lista2, lista3: tListaOrdenada;
	e: tElemento;
BEGIN
	CrearVacia (lista);
	Construir (lista, 2);
	MostrarLista (lista);
	WRITELN;
	Construir (lista, 1);
	MostrarLista(lista);
{
	Construir (lista, 6);
	Construir (lista, 7);
	Construir (lista, 4);
	Construir (lista, 2);
	MostrarLista (lista);
	WRITELN;
	CrearVacia (lista2);
	Construir (lista2, 8);
	Construir (lista2, 9);
	READLN;
	Construir (lista2, 3);
	Concatenar (lista, lista2, lista3);
	MostrarLista (lista3);}
	READLN;
END.
