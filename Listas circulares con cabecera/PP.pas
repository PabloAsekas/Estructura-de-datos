/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasCircularesCabecera;
VAR
	lista: tListasCircularesCabecera;
	e: tElemento;
BEGIN
	CrearVacia (lista);
	Construir (lista, 2);
	Construir (lista, 3);
	Construir (lista, 3);
	Construir (lista, 5);
	Construir (lista, 6);
	Construir (lista, 1);
	MostrarLista (lista);
	WRITELN;
	Primero (lista, e);
	WRITELN ('El primero es: ', e);
	Resto (lista);
	MostrarLista (lista);
	WRITELN ('La longitud es ', Longitud (lista));
	WRITELN (Pertenece(lista, 90));
	WRITELN;
	BorrarElemento (lista, 5);
	Construir (lista, 9);
	InsertarFinal (lista, 4);
	BorrarElemento (lista, 4);
	MostrarLista (lista);
	READLN;
END.

