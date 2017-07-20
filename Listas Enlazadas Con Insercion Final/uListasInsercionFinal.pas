/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasInsercionFinal;

INTERFACE
	USES uElemTAD;
	TYPE
		tListasInsercionFinal = ^tNodo;
		tNodo = RECORD
			info: tElemento;
			sig: tListasInsercionFinal;
		END;

	PROCEDURE CrearVacia (VAR lista: tListasInsercionFinal);
	PROCEDURE Construir (VAR lista: tListasInsercionFinal; e: tElemento);

	PROCEDURE Primero (lista: tListasInsercionFinal; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListasInsercionFinal);
	PROCEDURE Ultimo (lista: tListasInsercionFinal; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListasInsercionFinal):boolean;
	FUNCTION Longitud (lista: tListasInsercionFinal):integer;
	FUNCTION Pertenece (lista: tListasInsercionFinal; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListasInsercionFinal);

	PROCEDURE EliminarElemento (VAR lista: tListasInsercionFinal; e: tElemento);
	PROCEDURE Concatenar (lista, lista2: tListasInsercionFinal; VAR lista3: tListasInsercionFinal);


IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListasInsercionFinal);
		BEGIN
			lista:=NIL;
		END;
	PROCEDURE Construir (VAR lista: tListasInsercionFinal; e: tElemento);
		VAR
			aux, aux2: tListasInsercionFinal;
		BEGIN
			new(aux);
			AsignarElemento(aux^.info, e);
			IF EsVacia(lista) THEN
				BEGIN
					aux^.sig:=lista;
					lista:=aux;
				END
			ELSE
				BEGIN
					aux2:=lista;
					WHILE (aux2^.sig <> NIL) DO
						aux2:=aux2^.sig;
				aux^.sig:=NIL;
				aux2^.sig:=aux;
				END;
		END;

	PROCEDURE Primero (lista: tListasInsercionFinal; VAR e: tElemento);
		BEGIN
			IF EsVacia (lista) THEN
				AsignarElemento (e, lista^.info);

		END;

	PROCEDURE Resto (VAR lista: tListasInsercionFinal);
		VAR
			aux: tListasInsercionFinal;
		BEGIN
			IF NOT EsVacia (lista) THEN
				BEGIN
					aux:=lista;
					lista:=aux^.sig;
					dispose(aux);
				END;
		END;
	PROCEDURE Ultimo (lista: tListasInsercionFinal; VAR e: tElemento);
		VAR
			aux: tListasInsercionFinal;
		BEGIN
			IF NOT EsVacia (lista) THEN
				BEGIN
					aux:=lista;
					WHILE (aux^.sig <> NIL) DO
						aux:=aux^.sig;
					AsignarElemento (e, aux^.info);
				END;
		END;

	FUNCTION EsVacia (lista: tListasInsercionFinal):boolean;
		BEGIN
			EsVacia:=(lista = NIL);
		END;

	FUNCTION Longitud (lista: tListasInsercionFinal):integer;
		VAR
			aux: tListasInsercionFinal;
			ultimo: integer;
		BEGIN
			ultimo:=0;
			aux:=lista;
			IF NOT EsVacia(lista) THEN
				BEGIN
					WHILE (aux^.sig <> NIL) DO
						BEGIN
							ultimo:=ultimo+1;
							aux:=aux^.sig;
						END;
					ultimo:=ultimo+1;
				END;
			Longitud:=ultimo;
		END;

	FUNCTION Pertenece (lista: tListasInsercionFinal; e: tElemento):boolean;
		VAR
			aux: tListasInsercionFinal;
			esta: boolean;
		BEGIN
			aux:=lista;
			esta:=FALSE;
			IF NOT (EsVacia(lista)) THEN
				BEGIN
					WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
						aux:=aux^.sig;
					IF (aux^.info = e) THEN
						esta:=TRUE;
				END;
			Pertenece:=esta;
		END;

	PROCEDURE MostrarLista (lista: tListasInsercionFinal);
		VAR
			aux: tListasInsercionFinal;
		BEGIN
			IF EsVacia (lista) THEN
				WRITELN ('La lista esta vacia')
			ELSE
				BEGIN
					aux:=lista;
					WHILE (aux^.sig <> NIL) DO
						BEGIN
							WRITELN(aux^.info);
							aux:=aux^.sig;
						END;
					WRITELN(aux^.info);
				END;
		END;

	PROCEDURE EliminarElemento (VAR lista: tListasInsercionFinal; e: tElemento);
		VAR
			aux, aux2: tListasInsercionFinal;
		BEGIN
			IF NOT (EsVacia(lista)) THEN
				BEGIN
					aux:=lista;
					aux2:=NIL;
					WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
						BEGIN
							aux2:=aux;
							aux:=aux^.sig;
						END;
					IF (aux2 = NIL) THEN
						BEGIN
							lista:=lista^.sig;
						END
					ELSE
						IF (aux^.info = e) THEN
							BEGIN
								aux2^.sig:=aux^.sig;
								dispose(aux);
							END;
				END;
		END;

	PROCEDURE Concatenar (lista, lista2: tListasInsercionFinal; VAR lista3: tListasInsercionFinal);
		VAR
			aux: tListasInsercionFinal;
		BEGIN
			IF EsVacia(lista) THEN
				IF EsVacia(lista2) THEN
					CrearVacia(lista3)
				ELSE
					BEGIN
						aux:=lista2;
						REPEAT
							Construir(lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = NIL);
					END
			ELSE
				IF EsVacia(lista2) THEN
					BEGIN
						aux:=lista;
						REPEAT
							Construir(lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = NIL);
					END
				ELSE
					BEGIN
						aux:=lista;
						REPEAT
							Construir(lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = NIL);
						aux:=lista2;
						REPEAT
							Construir(lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = NIL);
					END;
		END;
END.
