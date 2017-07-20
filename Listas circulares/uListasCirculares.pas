/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasCirculares;
INTERFACE
USES uElemTAD;
	TYPE
		tListasCirculares = ^tNodo;
		tNodo = RECORD
			info: tElemento;
			sig: tListasCirculares;
		END;

	PROCEDURE CrearVacia (VAR lista: tListasCirculares);
	PROCEDURE Construir (VAR lista: tListasCirculares; e: tElemento);

	PROCEDURE Primero (lista: tListasCirculares; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListasCirculares);
	PROCEDURE Ultimo (lista: tListasCirculares; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListasCirculares):boolean;
	FUNCTION Longitud (lista: tListasCirculares):integer;
	FUNCTION Pertenece (lista: tListasCirculares; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListasCirculares);

	PROCEDURE Concatenar (lista1, lista2: tListasCirculares; VAR lista3: tListasCirculares);
	PROCEDURE BorrarElemento (VAR lista: tListasCirculares; e: tElemento);
	PROCEDURE InsertarFinal (VAR lista: tListasCirculares; e: tElemento);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListasCirculares);
		BEGIN
			lista:=NIL;
		END;
	PROCEDURE Construir (VAR lista: tListasCirculares; e: tElemento);
		VAR
			aux, aux2: tListasCirculares;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			IF EsVacia (lista) THEN
				BEGIN
					lista:=aux;
					aux^.sig:=lista;
				END
			ELSE
				BEGIN
					aux2:=lista;
					REPEAT
						aux2:=aux2^.sig;
					UNTIL (aux2^.sig = lista);
					aux2^.sig:=aux;
					aux^.sig:=lista;
				END;
		END;

	PROCEDURE Primero (lista: tListasCirculares; VAR e: tElemento);
		BEGIN
			AsignarElemento (e, lista^.info);
		END;
	PROCEDURE Resto (VAR lista: tListasCirculares);
		VAR
			aux, aux2: tListasCirculares;
		BEGIN
			IF NOT EsVacia(lista) THEN
				IF (lista^.sig = lista) THEN
					BorrarElemento (lista, lista^.info)
				ELSE
					BEGIN
						aux:=lista;
						aux2:=lista;
						REPEAT
							aux2:=aux2^.sig;
						UNTIL (aux2^.sig = lista);
						lista:=lista^.sig;
						aux2^.sig:=lista;
						dispose(aux);
					END;
		END;
	PROCEDURE Ultimo (lista: tListasCirculares; VAR e: tElemento);
		VAR
			aux: tListasCirculares;
		BEGIN
			IF NOT EsVacia(lista) THEN
				BEGIN
					aux:=lista;
					WHILE (aux^.sig <> lista) DO
						aux:=aux^.sig;
					AsignarElemento(e, aux^.info);
				END;
		END;

	FUNCTION EsVacia (lista: tListasCirculares):boolean;
		BEGIN
			EsVacia:=(lista = NIL);
		END;
	FUNCTION Longitud (lista: tListasCirculares):integer;
		VAR
			a: integer;
			aux: tListasCirculares;
		BEGIN
			a:=0;
			aux:=lista;
			IF EsVacia(lista) THEN
				a:=0
			ELSE
				BEGIN
					WHILE (aux^.sig <> lista) DO
						BEGIN
							aux:=aux^.sig;
							a:=a+1;
						END;
					a:=a+1;
				END;
			Longitud:=a;
		END;
	FUNCTION Pertenece (lista: tListasCirculares; e: tElemento):boolean;
		VAR
			error: boolean;
			aux: tListasCirculares;
		BEGIN
			IF EsVacia(lista) THEN
				error:=false
			ELSE
				BEGIN
					aux:=lista;
					WHILE ((aux^.info <> e) AND (aux^.sig <> lista)) DO
						BEGIN
							aux:=aux^.sig;
						END;
					IF aux^.info = e THEN
						error:=true;
				END;
			Pertenece:=error;
		END;
	PROCEDURE MostrarLista (lista: tListasCirculares);
		VAR
			aux: tListasCirculares;
		BEGIN
			IF EsVacia(lista) THEN
				WRITELN ('La lista es vacia')
			ELSE
				BEGIN
					aux:=lista;
					REPEAT
						WRITELN (aux^.info);
						aux:=aux^.sig;
					UNTIL (aux = lista);
				END;
		END;

	PROCEDURE Concatenar (lista1, lista2: tListasCirculares; VAR lista3: tListasCirculares);
		VAR
			aux: tListasCirculares;
		BEGIN
			IF EsVacia(lista1) THEN
				IF EsVacia(lista2) THEN
					CrearVacia(lista3)
				ELSE
					BEGIN
						aux:=lista2;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista2);
					END
			ELSE
				IF EsVacia(lista2) THEN
					BEGIN
						aux:=lista1;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista1);
					END
				ELSE
					BEGIN
						aux:=lista1;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista1);
						aux:=lista2;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista2);
					END;
		END;
	PROCEDURE BorrarElemento (VAR lista: tListasCirculares; e: tElemento);
		VAR
			aux, aux2: tListasCirculares;
		BEGIN
			aux:=lista;
			aux2:=NIL;
			IF (lista^.info = e) THEN
				BEGIN
					REPEAT
						aux:=aux^.sig;
					UNTIL (aux^.sig = lista);
					aux2:=lista;
					aux^.sig:=lista^.sig;
					lista:=lista^.sig;
					dispose(aux2);
				END
			ELSE
				BEGIN
					WHILE ((aux^.sig <> lista) AND (aux^.info <> e)) DO
						BEGIN
							aux2:=aux;
							aux:=aux^.sig;
						END;
					IF (aux^.info = e) THEN
						BEGIN
							aux2^.sig:=aux^.sig;
							dispose(aux);
						END;
				END;
		END;
	PROCEDURE InsertarFinal (VAR lista: tListasCirculares; e: tElemento);
		VAR
			aux, aux2: tListasCirculares;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			aux2:=lista;
			REPEAT
				aux2:=aux2^.sig;
			UNTIL (aux2^.sig = lista);
			aux2^.sig:=aux;
			aux^.sig:=lista;
			lista:=aux;


		END;
END.
