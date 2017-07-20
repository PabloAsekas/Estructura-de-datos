/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uPilas;
INTERFACE
	USES uElemTAD;
	TYPE
		uPilas: ^tNodo;
		tNodo = RECORD
			info: tElemento;
			sig: uPilas;
		END;

	PROCEDURE CrearVacia (VAR pila: uPilas);
	PROCEDURE Apilar (VAR pila: uPilas; e: tElemento);

	PROCEDURE Primero (pila: uPilas; VAR e: tElemento);
	PROCEDURE Resto (VAR pila: uPilas);
	PROCEDURE Ultimo (pila: uPilas; VAR e: tElemento);

	FUNCTION EsVacia (pila: uPilas):boolean;
	FUNCTION Longitud (pila: uPilas):integer;
	FUNCTION Pertenece (pila: uPilas; e: tElemento):boolean;
	PROCEDURE MostrarPila (pila: uPilas);

	PROCEDURE Concatenar (pila1, pila2: uPilas; VAR pila3: uPilas);
	PROCEDURE Eliminar (VAR pila: uPilas);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR pila: uPilas);
		BEGIN
			pila:=NIL;
		END;

	PROCEDURE Apilar (VAR pila: uPilas; e: tElemento);
		VAR
			aux: uPilas;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			aux^.sig:=pila;
			pila:=aux;
		END;

	PROCEDURE Primero (pila: uPilas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (pila)) THEN
				AsignarElemento (e, pila^.info);
		END;

	PROCEDURE Resto (VAR pila: uPilas);
		VAR
			aux: uPilas;
		BEGIN
			IF NOT (EsVacia (pila)) THEN
				BEGIN
					pila:=aux;
					pila:=pila^.sig;
					dispose (aux);
				END;
		END;

	PROCEDURE Ultimo (pila: uPilas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (pila)) THEN
				BEGIN
					WHILE pila^.sig <> NIL DO
						pila:=pila^.sig;
					AsignarElemento (e, pila^.info);
				END;
		END;

	FUNCTION EsVacia (pila: uPilas):boolean;
		BEGIN
			EsVacia:=(pila = NIL);
		END;

	FUNCTION Longitud (pila: uPilas):integer;
		VAR
			i: integer;
		BEGIN
			i:=0;
			IF NOT (EsVacia (pila)) THEN
				WHILE (pila <> NIL) DO
					BEGIN
						i:=i+1;
						pila:=pila^.sig;
					END;
			Longitud:=i;
		END;

	FUNCTION Pertenece (pila: uPilas; e: tElemento):boolean;
		BEGIN

		END;

	PROCEDURE MostrarPila (pila: uPilas);
		BEGIN
			IF (EsVacia (pila)) THEN
				WRITELN ('Es vacia')
			ELSE
				WHILE (pila <> NIL) DO
					BEGIN
						WRITELN (pila^.info);
						pila:=pila^.sig;
					END;
		END;

	PROCEDURE Concatenar (pila1, pila2: uPilas; VAR pila3: uPilas);
		BEGIN

		END;

	PROCEDURE Eliminar (VAR pila: uPilas);
		VAR
			aux: uPilas;
		BEGIN
			IF NOT (EsVacia (pila)) THEN
				BEGIN
					pila:=aux;
					pila:=pila^.sig;
					dispose (aux);
				END;
		END;
END.
