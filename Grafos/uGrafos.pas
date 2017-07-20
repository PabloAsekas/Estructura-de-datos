/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uGrafos;
INTERFACE
	USES uElemTAD;

	TYPE
		tNodo: ^tNodo;
		tipoNodo = RECORD
			info: tElemento;
			sig: tNodo;
			peso: integer;
		END;
		tGrafo: ^tGrafo;
		tipoGrafo = RECORD
			info: tElemento;
			adyacente: ^tNodo;
			sig: tGrafo;
		END;

	PROCEDURE CrearGrafoVacio (VAR grafo: tGrafo);
	PROCEDURE InsertarNodo (VAR grafo: tGrafo; e: tElemento);
	PROCEDURE InsertarAdyacente (VAR grafo: tGrafo; e1, e2: tElemento; peso: integer);
	FUNCTION BuscarNodo (grafo: tGrafo, e2: tElemento):boolean;
	PROCEDURE ImprimirGrafo (grafo: tGrafo);



IMPLEMENTATION
	PROCEDURE CrearGrafoVacio (VAR grafo: tGrafo);
		BEGIN
			grafo:=NIL;
		END;

	PROCEDURE InsertarNodo (VAR grafo: tGrafo; e: tElemento);
		VAR
			aux: tGrafo;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			aux^.adyacente:=NIL;
			aux^.sig:=grafo;
			grafo:=aux;
		END;

	PROCEDURE InsertarAdyacente (VAR grafo: tGrafo; e1, e2: tElemento; peso: integer);
		VAR
			aux: tGrafo;
			aux2: tNodo;
		BEGIN
			IF NOT EsVacio (grafo) THEN
				BEGIN
					IF (BuscarNodo (grafo, e2)) THEN
						BEGIN
							aux:=grafo;
							WHILE ((aux^.info <> e1) AND (aux^.sig <> NIL)) DO
								aux:=aux^.sig;
							IF (aux^.info = e) THEN
								BEGIN
									new (aux2);
									AsignarElemento (aux2^.info, e2);
									AsignarElemento (aux2^.peso, peso);
									aux2^.sig:=aux^.adyacente;
									aux^.adyacente:=aux2;
								END;
						END;
				END;
		END;

	FUNCTION BuscarNodo (grafo: tGrafo, e2: tElemento):boolean;
		BEGIN
			WHILE ((grafo^.info <> e2) AND (grafo^.sig <> NIL)) DO
				grafo:=grafo^.sig;
			IF (grafo^.info = e2) THEN
				BuscarNodo:=TRUE
			ELSE
				BuscarNodo:=FALSE;
		END;

		{tNodo: ^tNodo;
		tipoNodo = RECORD
			info: tElemento;
			nodo: tNodo;
			peso: integer;
		END;
		tGrafo: ^tGrafo;
		tipoGrafo = RECORD
			info: tElemento;
			adyacente: ^tNodo;
			sig: tGrafo;
		END;}

	PROCEDURE ImprimirGrafo (grafo: tGrafo);
	BEGIN
		IF EsVacio (grafo) THEN
			WRITELN ('El grafo es vacio')
		ELSE
			BEGIN
				WHILE (grafo <> NIL) DO
					BEGIN
						WRITELN ('Nodo ', grafo^.info);
						WRITELN ('Adyacente');
						WHILE (grafo^.adyacente <> NIL) DO
							BEGIN
								WRITELN ('-'. grafo^.adyacente^.info);
								grafo^.adyacente:=grafo^.adyacente^.sig;
							END;
						grafo:=grafo^.sig;
					END;
			END;
	END;
END.
