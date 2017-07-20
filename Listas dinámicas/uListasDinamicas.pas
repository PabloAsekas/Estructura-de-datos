/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasDinamicas;

INTERFACE
	USES uElemTAD;
		TYPE
			tListaDinamica = ^TipoNodo;
			TipoNodo = RECORD
				info: tElemento;
				sig: tListaDinamica;
		END;

	{Constructoras generadoras}
	PROCEDURE CrearVacia (VAR lista: tListaDinamica);
	PROCEDURE Construir (VAR lista: tListaDinamica; e: tElemento);

	{Observadoras selectoras}
	PROCEDURE Primero (lista: tListaDinamica; VAR e: tElemento);
	PROCEDURE Resto (lista: tListaDinamica; VAR lista2: tListaDinamica);
	FUNCTION Ultimo (lista: tListaDinamica):tElemento;

	{Observadoras no selectoras}
	FUNCTION EsVacia (lista: tListaDinamica):boolean;
	FUNCTION Longitud (lista: tListaDinamica):integer;
	FUNCTION Pertenece (lista: tListaDinamica; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListaDinamica);

	{Constructores no generadoras}
	PROCEDURE Concatenar (lista1, lista2: tListaDinamica; VAR lista3: tListaDinamica);
	PROCEDURE BorrarElemento (VAR lista: tListaDinamica; e: tElemento);
	PROCEDURE InsertarFinal (VAR lista: tListaDinamica; e: tElemento);


IMPLEMENTATION

	{Constructoras generadoras}
	PROCEDURE CrearVacia (VAR lista: tListaDinamica);
		BEGIN
			lista:=NIL;
		END;

	PROCEDURE Construir (VAR lista: tListaDinamica; e: tElemento);
		VAR
			aux: tListaDinamica;
		BEGIN
			new(aux);
			AsignarElemento(aux^.info, e);
			aux^.sig:=lista;
			lista:=aux;
		END;

	{Observadoras selectoras}
	PROCEDURE Primero (lista: tListaDinamica; VAR e: tElemento);
		BEGIN
			AsignarElemento (e, lista^.info);
		END;

	PROCEDURE Resto (lista: tListaDinamica; VAR lista2: tListaDinamica);
		BEGIN
			lista2:=lista^.sig;
		END;

	{Observadoras no selectoras}
	FUNCTION EsVacia (lista: tListaDinamica):boolean;
		BEGIN
			EsVacia:=(lista = NIL);
		END;

	FUNCTION Longitud (lista: tListaDinamica):integer;
		VAR
			i: integer;
			aux: tListaDinamica;
		BEGIN
			i:=0;
			aux:=lista;
			WHILE (aux^.sig <> NIL) DO
				BEGIN
					aux:=aux^.sig;
					i:=i+1;
				END;
			Longitud:=i;
		END;

	FUNCTION Ultimo (lista: tListaDinamica):tElemento;
		VAR
			aux: tListaDinamica;
		BEGIN
			aux:=lista;
			WHILE (aux^.sig <> NIL) DO
				aux:=aux^.sig;
			Ultimo:=aux^.info;
		END;

	FUNCTION Pertenece (lista: tListaDinamica; e: tElemento):boolean;
		VAR
			esta: boolean;
			aux: tListaDinamica;
		BEGIN
			esta:=FALSE;
			aux:=lista;
			WHILE ((aux^.sig <> NIL) AND (aux^.info <> e)) DO
				aux:=aux^.sig;
			IF (aux^.sig <> NIL) THEN
				esta:=TRUE
			ELSE
				BEGIN
					IF (aux^.info = e) THEN
						esta:=TRUE;
				END;
			Pertenece:=esta;
		END;

	PROCEDURE MostrarLista (lista: tListaDinamica);
		VAR
			aux: tListaDinamica;
		BEGIN
			new(aux);
			aux:=lista;
			REPEAT
				WRITELN(aux^.info);
				aux:=aux^.sig;
			UNTIL (aux = NIL);
		END;

	{Constructores no generadoras}
	PROCEDURE Concatenar (lista1, lista2: tListaDinamica; VAR lista3: tListaDinamica);
		VAR
			aux: tListaDinamica;
		BEGIN
			aux:=lista1;
			WHILE (aux^.sig <> NIL) DO
				aux:=aux^.sig;
			aux^.sig:=lista2;
			lista3:=lista1;
		END;

	PROCEDURE BorrarElemento (VAR lista: tListaDinamica; e: tElemento);
		VAR
			aux, aux2: tListaDinamica;
		BEGIN
			aux:=lista^.sig;
			aux2:=lista;
			IF (aux2^.info = e) THEN
				lista:=lista^.sig
			ELSE
				BEGIN
					WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
						BEGIN
							aux:=aux^.sig;
							aux2:=aux2^.sig;
						END;
					aux2^.sig:=aux^.sig;
				END;
		END;

	PROCEDURE InsertarFinal (VAR lista: tListaDinamica; e: tElemento);
		VAR
			aux, aux2: tListaDinamica;
		BEGIN
			aux:=lista;
			WHILE (aux^.sig <> NIL) DO
				aux:=aux^.sig;
			new (aux2);
			AsignarElemento(aux2^.info, e);
			aux^.sig:=aux2;
		END;

END.
