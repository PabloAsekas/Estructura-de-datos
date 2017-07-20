/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

PROGRAM PP;
USES uElemTAD, uListasDoblementeEnlazadasConPunteroPrincipioYFin;
VAR
	lista, lista1, lista2, lista3: tListas;
	e: tElemento;
BEGIN
	CrearVacia (lista);
	Construir (lista, 1);
	Construir (lista, 2);
	Construir (lista, 3);
	Construir (lista, 4);
	MostrarLista (lista);
	WRITELN;
	Primero (lista, e);
	WRITELN ('El primero de la lista es: ', e);
	WRITELN;
	Ultimo (lista, e);
	WRITELN ('El ultimo de la lista es: ', e);
	WRITELN;
	WRITELN ('La longitud es: ', Longitud (lista));
	WRITELN (Pertenece (lista, 9));
	CrearVacia (lista1);
	CrearVacia (lista2);
	Construir (lista1, 1);
	Construir (lista1, 2);
	Construir (lista2, 3);
	Construir (lista2, 4);
	Concatenar (lista1, lista2, lista3);
	InsertarFinal (lista3, 0);
	BorrarElemento (lista3, 9);
	MostrarLista (lista3);
	READLN;
END.
