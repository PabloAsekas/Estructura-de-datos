/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasCirculares;

VAR
	lista, lista2, lista3: tListasCirculares;

	e: tElemento;
BEGIN
	CrearVacia (lista);
	Construir (lista, 1);
	Construir (lista, 2);
	Construir (lista, 3);
	Construir (lista, 4);
	MostrarLista (lista);
	WRITELN;
	BorrarElemento (lista, 1);
	MostrarLista (lista);
	READLN;
END.
