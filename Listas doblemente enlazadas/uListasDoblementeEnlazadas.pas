/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasDoblementeEnlazadas;
INTERFACE
USES uElemTAD;
TYPE
	tListaDoblementeEnlazada = ^tNodo;
	tNodo = RECORD
		ant, sig: tListaDoblementeEnlazada;
		info: tElemento;
	END;

	PROCEDURE CrearVacia (VAR lista: tListaDoblementeEnlazada);
	PROCEDURE Construir (VAR lista: tListaDoblementeEnlazada; e: tElemento);

	PROCEDURE Primero (lista: tListaDoblementeEnlazada; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListaDoblementeEnlazada);
	PROCEDURE Ultimo (lista: tListaDoblementeenlazada; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListaDoblementeEnlazada): boolean;
	FUNCTION Longitud (lista: tListaDoblementeEnlazada): integer;
	FUNCTION Pertenece (lista: tListaDoblementeEnlazada; e: tElemento): boolean;
	PROCEDURE MostrarLista (lista: tListaDoblementeEnlazada);

	PROCEDURE Concatenar (lista1, lista2: tListaDoblementeEnlazada; VAR lista3: tListaDoblementeEnlazada);
	PROCEDURE BorrarElemento (VAR lista: tListaDoblementeEnlazada; e: tElemento);
	PROCEDURE InsertarFinal (VAR listA: tListaDoblementeEnlazada; e: tElemento);



IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListaDoblementeEnlazada);
		BEGIN
			lista:=NIL;
		END;

	PROCEDURE Construir (VAR lista: tListaDoblementeEnlazada; e: tElemento);
		VAR
			aux, aux2: tListaDoblementeEnlazada;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			IF EsVacia (lista) THEN
				BEGIN
					aux^.sig:=NIL;
					aux^.ant:=NIL;
					lista:=aux;
				END
			ELSE
				BEGIN
					aux2:=lista;
					WHILE (aux2^.sig <> NIL) DO
						aux2:=aux2^.sig;
					aux2^.sig:=aux;
					aux^.ant:=aux2;
					aux^.sig:=NIL;
				END;
		END;

	PROCEDURE Primero (lista: tListaDoblementeEnlazada; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				AsignarElemento (e, lista^.info);
		END;

	PROCEDURE Resto (VAR lista: tListaDoblementeEnlazada);
		VAR
			aux: tListaDoblementeEnlazada;
		BEGIN
			aux:=lista;
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					lista:=lista^.sig;
					lista^.ant:=NIL;
					dispose (aux);
				END;
		END;

	PROCEDURE Ultimo (lista: tListaDoblementeenlazada; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					WHILE (lista^.sig <> NIL) DO
						lista:=lista^.sig;
					AsignarElemento (e, lista^.info);
				END;
		END;

	FUNCTION EsVacia (lista: tListaDoblementeEnlazada): boolean;
		BEGIN
			EsVacia:= (lista = NIL);
		END;

	FUNCTION Longitud (lista: tListaDoblementeEnlazada): integer;
		VAR
			i: integer;
		BEGIN
			i:=0;
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					WHILE (lista <> NIL) DO
						BEGIN
							i:=i+1;
							lista:=lista^.sig;
						END;
				END;
			Longitud:=i;
		END;

	FUNCTION Pertenece (lista: tListaDoblementeEnlazada; e: tElemento): boolean;
		BEGIN
			WHILE ((lista^.sig <> NIL) AND (lista^.info <> e)) DO
				lista:=lista^.sig;
			IF (lista^.info <> e) THEN
				Pertenece:=FALSE
			ELSE
				Pertenece:=TRUE;
		END;

	PROCEDURE MostrarLista (lista: tListaDoblementeEnlazada);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				REPEAT
					WRITELN (lista^.info);
					lista:=lista^.sig;
				UNTIL (lista = NIL)
			ELSE
				WRITELN ('La lista es vacia');
		END;

	PROCEDURE Concatenar (lista1, lista2: tListaDoblementeEnlazada; VAR lista3: tListaDoblementeEnlazada);
		BEGIN
			IF EsVacia (lista1) THEN
				IF EsVacia (lista2) THEN
					CrearVacia (lista3)
				ELSE
					REPEAT
						Construir (lista3, lista2^.info);
						lista2:=lista2^.sig;
					UNTIL (lista2 = NIL)
			ELSE
				IF EsVacia (lista2) THEN
					REPEAT
						Construir (lista3, lista1^.info);
						lista1:=lista1^.sig;
					UNTIL (lista1 = NIL)
				ELSE
					BEGIN
						REPEAT
							Construir (lista3, lista1^.info);
							lista1:=lista1^.sig;
						UNTIL (lista1 = NIL);
						REPEAT
							Construir (lista3, lista2^.info);
							lista2:=lista2^.sig;
						UNTIL (lista2 = NIL);
					END;
		END;

	PROCEDURE BorrarElemento (VAR lista: tListaDoblementeEnlazada; e: tElemento);
		VAR
			aux: tListaDoblementeEnlazada;
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					IF (lista^.info = e) THEN
						BEGIN
							aux:=lista;
							lista:=lista^.sig;
							lista^.ant:=NIL;
							dispose (aux);
						END
					ELSE
						BEGIN
							aux:=lista;
							WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
							aux:=aux^.sig;
							IF ((aux^.info = e) AND (aux^.sig = NIL)) THEN
								BEGIN
									aux^.ant^.sig:=NIL;
									dispose (aux);
								END
							ELSE
								BEGIN
									aux^.ant^.sig:=aux^.sig;
									aux^.sig^.ant:=aux^.ant;
									dispose (aux);
								END;
						END;
				END;
		END;

	PROCEDURE InsertarFinal (VAR lista: tListaDoblementeEnlazada; e: tElemento);
		VAR
			aux: tListaDoblementeEnlazada;
		BEGIN
			IF (EsVacia (lista)) THEN
				Construir (lista, e)
			ELSE
				BEGIN
					new (aux);
					AsignarElemento (aux^.info, e);
					lista^.ant:=aux;
					aux^.sig:=lista;
					aux^.ant:=NIL;
					lista:=aux;
				END;
		END;
END.
