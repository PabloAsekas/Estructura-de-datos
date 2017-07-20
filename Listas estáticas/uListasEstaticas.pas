/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasEstaticas;
INTERFACE
	USES uElemTAD;
	CONST
		MAX = 6;
	TYPE
		tListaEstatica = RECORD
			almacen: ARRAY [1..MAX] of tElemento;
			tope: 0..MAX;
		END;

	{Constructoras generadoras}
	PROCEDURE CrearVacia (VAR lista: tListaEstatica);
	PROCEDURE Construir (VAR lista: tListaEstatica; e: tElemento);

	{Observadoras selectoras}

	PROCEDURE Primero (lista: tListaEstatica; VAR e: tElemento);
	PROCEDURE Resto (lista: tListaEstatica; VAR lista2: tListaEstatica);

	{Observadoras no selectoras}
	FUNCTION EsVacia (lista: tListaEstatica):boolean;
	FUNCTION Longitud (lista: tListaEstatica):integer;
	FUNCTION Ultimo (lista: tListaEstatica):tElemento;
	FUNCTION Pertenece (lista: tListaEstatica; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListaEstatica);

	{Constructoras no generadoras}
	PROCEDURE Concatenar (lista1, lista2: tListaEstatica; VAR lista3: tListaEstatica);
	PROCEDURE BorrarElemento (VAR lista: tListaEstatica; e: tElemento);
	PROCEDURE InsertarFinal (VAR lista: tListaEstatica; e: tElemento);


IMPLEMENTATION

	{Constructoras generadoras}
	PROCEDURE CrearVacia (VAR lista: tListaEstatica);
		BEGIN
			lista.tope:=0;
		END;

	PROCEDURE Construir (VAR lista: tListaEstatica; e: tElemento);
		BEGIN
			IF (lista.tope < MAX) THEN
				BEGIN
					lista.tope:=lista.tope+1;
					AsignarElemento(lista.almacen[lista.tope], e);
				END;
		END;
	{Observadoras selectoras}

	PROCEDURE Primero (lista: tListaEstatica; VAR e: tElemento);
		BEGIN
			IF (lista.tope > 0) THEN
				AsignarElemento (e, lista.almacen[lista.tope]);
		END;

	PROCEDURE Resto (lista: tListaEstatica; VAR lista2: tListaEstatica);
		BEGIN
			lista2.tope:= lista.tope-1;
			lista2.almacen:=lista.almacen;
		END;

	{Observadoras no selectoras}
	FUNCTION EsVacia (lista: tListaEstatica):boolean;
		BEGIN
			EsVacia:=(SonIguales(lista.tope, 0));
		END;

	FUNCTION Longitud (lista: tListaEstatica):integer;
		BEGIN
			Longitud:=lista.tope;
		END;

	FUNCTION Ultimo (lista: tListaEstatica):tElemento;
		BEGIN
			Ultimo:=lista.almacen[1];
		END;

	FUNCTION Pertenece (lista: tListaEstatica; e: tElemento):boolean;
		VAR
			i: integer;
			esta: boolean;
		BEGIN
			i:=1;
			esta:=FALSE;
			REPEAT
				IF (SonIguales(lista.almacen[i], e)) THEN
					esta:=TRUE;
				i:=i+1;
			UNTIL ((esta = TRUE) OR (i = lista.tope));
			Pertenece:=esta;
		END;

	PROCEDURE MostrarLista (lista: tListaEstatica);
		VAR
			i: integer;
		BEGIN
			FOR i:=1 TO lista.tope DO
				WRITELN (lista.almacen[i]);
		END;

	{Constructoras no generadoras}
	PROCEDURE Concatenar (lista1, lista2: tListaEstatica; VAR lista3: tListaEstatica);
		VAR
			i: integer;
		BEGIN
			IF ((lista1.tope + lista2.tope) <= MAX) THEN
				BEGIN
					FOR i:=1 TO lista1.tope DO
						lista3.almacen[i]:=lista1.almacen[i];
					lista3.tope:=lista1.tope;
					FOR i:=1 TO lista2.tope DO
						lista3.almacen[lista3.tope+i]:=lista2.almacen[i];
					lista3.tope:=lista3.tope+lista2.tope;
				END;
		END;

	PROCEDURE BorrarElemento (VAR lista: tListaEstatica; e: tElemento);
		VAR
			i,j: integer;
		BEGIN
			i:=1;
 			WHILE (i <= lista.tope) DO
				BEGIN
					IF SonIguales(lista.almacen[i], e) THEN
						BEGIN
							FOR j:=i TO lista.tope DO
								lista.almacen[i]:=lista.almacen[i+1];
							lista.tope:=lista.tope-1;
						END;
					i:=i+1;
				END;
		END;

	PROCEDURE InsertarFinal (VAR lista: tListaEstatica; e: tElemento);
		VAR
			i: integer;
		BEGIN
			IF (lista.tope < MAX) THEN
				BEGIN
					FOR i:=1 DOWNTO lista.tope DO
						lista.almacen[i+1]:=lista.almacen[i];
					lista.almacen[1]:=e;
					lista.tope:=lista.tope+1;
				END;
		END;
END.
