/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasDoblementeEnlazadasConPunteroPrincipioYFin;
INTERFACE
USES uElemTAD;
TYPE
	tipoNodo = ^tNodo;
	tListas = RECORD
		pri, ult: tipoNodo;
	END;
	tNodo = RECORD
		sig, ant: tipoNodo;
		info: tElemento;
	END;

	PROCEDURE CrearVacia (VAR lista: tListas);
	PROCEDURE Construir (VAR lista: tListas; e: tElemento);

	PROCEDURE Primero (lista: tListas; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListas);
	PROCEDURE Ultimo (lista: tListas; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListas):boolean;
	FUNCTION Longitud (lista: tListas):integer;
	FUNCTION Pertenece (lista: tListas; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListas);

	PROCEDURE Concatenar (lista1, lista2: tListas; VAR lista3: tListas);
	PROCEDURE BorrarElemento (VAR lista: tListas; e: tElemento);
	PROCEDURE InsertarFinal (VAR lista: tListas; e: tElemento);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListas);
		BEGIN
			lista.pri:=NIL;
			lista.ult:=NIL;
		END;

	PROCEDURE Construir (VAR lista: tListas; e: tElemento);
		VAR
			aux: tipoNodo;
		BEGIN
			new(aux);
			AsignarElemento (aux^.info, e);
			IF (EsVacia (lista)) THEN
				BEGIN
					aux^.sig:=NIL;
					aux^.ant:=NIL;
					lista.pri:=aux;
					lista.ult:=aux;
				END
			ELSE
				BEGIN
					lista.ult^.sig:=aux;
					aux^.ant:=lista.ult;
					lista.ult:=aux;
					aux^.sig:=NIL;
				END;
		END;

	PROCEDURE Primero (lista: tListas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				AsignarElemento (e, lista.pri^.info);
		END;

	PROCEDURE Resto (VAR lista: tListas);
		VAR
			aux: tipoNodo;
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					aux:=lista.pri;
					lista.pri:=lista.pri^.sig;
					lista.pri^.ant:=NIL;
					dispose (aux);
				END;
		END;

	PROCEDURE Ultimo (lista: tListas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				AsignarElemento (e, lista.ult^.info);
		END;

	FUNCTION EsVacia (lista: tListas):boolean;
		BEGIN
			EsVacia:=((lista.pri = NIL) AND (lista.ult = NIL));
		END;

	FUNCTION Longitud (lista: tListas):integer;
		VAR
			i: integer;
		BEGIN
			i:=0;
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					WHILE (lista.pri <> NIL) DO
						BEGIN
							i:=i+1;
							lista.pri:=lista.pri^.sig;
						END;
				END;
			Longitud:=i;
		END;

	FUNCTION Pertenece (lista: tListas; e: tElemento):boolean;
		VAR
			i: boolean;
			aux: tipoNodo;
		BEGIN
			i:=FALSE;
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					aux:=lista.pri;
					WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
						aux:=aux^.sig;
					IF (aux^.info = e) THEN
						i:=TRUE;
				END;
			Pertenece:=i;
		END;

	PROCEDURE MostrarLista (lista: tListas);
		VAR
			aux: tipoNodo;
		BEGIN
			IF (EsVacia (lista)) THEN
				WRITELN ('La lista es vacia')
			ELSE
				BEGIN
					aux:=lista.pri;
					WHILE (aux <> NIL) DO
						BEGIN
							WRITELN (aux^.info);
							aux:=aux^.sig;
						END;
				END;
		END;

	PROCEDURE Concatenar (lista1, lista2: tListas; VAR lista3: tListas);
		BEGIN
			IF (EsVacia (lista1)) THEN
				IF (EsVacia (lista2)) THEN
					CrearVacia (lista3)
				ELSE
					WHILE (lista2.pri <> NIL) DO
						BEGIN
							Construir (lista3, lista2.pri^.info);
							lista2.pri:=lista2.pri^.sig;
						END
			ELSE
				IF (EsVacia (lista2)) THEN
					WHILE (lista1.pri <> NIL) DO
						BEGIN
							Construir (lista3, lista1.pri^.info);
							lista1.pri:=lista1.pri^.sig;
						END
				ELSE
					BEGIN
						WHILE (lista1.pri <> NIL) DO
							BEGIN
								Construir (lista3, lista1.pri^.info);
								lista1.pri:=lista1.pri^.sig;
							END;
						WHILE (lista2.pri <> NIL) DO
							BEGIN
								Construir (lista3, lista2.pri^.info);
								lista2.pri:=lista2.pri^.sig;
							END;
					END;
		END;

	PROCEDURE BorrarElemento (VAR lista: tListas; e: tElemento);
		VAR
			aux: tipoNodo;
		BEGIN
			IF (lista.pri^.info = e) THEN
				BEGIN
					aux:=lista.pri;
					lista.pri:=lista.pri^.sig;
					lista.pri^.ant:=NIL;
					dispose (aux);
				END
			ELSE
				IF (lista.ult^.info = e) THEN
					BEGIN
						aux:=lista.ult;
						lista.ult:=lista.ult^.ant;
						lista.ult^.sig:=NIL;
						dispose (aux);
					END
				ELSE
					BEGIN
						aux:=lista.pri;
						WHILE ((aux^.info <> e) AND (aux^.sig <> NIL)) DO
							aux:=aux^.sig;
						IF (aux^.info = e) THEN
							BEGIN
								aux^.ant^.sig:=aux^.sig;
								aux^.sig^.ant:=aux^.ant;
								dispose (aux);
							END;
					END;
		END;

	PROCEDURE InsertarFinal (VAR lista: tListas; e: tElemento);
		VAR
			aux: tipoNodo;
		BEGIN
			IF EsVacia (lista) THEN
				Construir (lista, e)
			ELSE
				BEGIN
					new (aux);
					AsignarElemento (aux^.info, e);
					aux^.sig:=lista.pri;
					lista.pri^.ant:=aux;
					aux^.ant:=NIL;
					lista.pri:=aux;
				END;
		END;
END.
