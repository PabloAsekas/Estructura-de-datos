/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasCircularesCabecera;
INTERFACE
	USES uElemTAD;
	TYPE
		tipoNodo = ^tNodo;
		tListasCircularesCabecera = RECORD
			pri, ult: tipoNodo;
		END;
		tNodo = RECORD
			info: tElemento;
			sig: tipoNodo;
		END;

	PROCEDURE CrearVacia (VAR lista: tListasCircularesCabecera);
	PROCEDURE Construir (VAR lista: tListasCircularesCabecera; e: tElemento);

	PROCEDURE Primero (lista: tListasCircularesCabecera; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListasCircularesCabecera);
	PROCEDURE Ultimo (lista: tListasCircularesCabecera; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListasCircularesCabecera):boolean;
	FUNCTION Longitud (lista: tListasCircularesCabecera):integer;
	FUNCTION Pertenece (lista: tListasCircularesCabecera; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListasCircularesCabecera);

	PROCEDURE Concatenar (lista1, lista2: tListasCircularesCabecera; VAR lista3: tListasCircularesCabecera);
	PROCEDURE BorrarElemento (VAR lista: tListasCircularesCabecera; e: tElemento);
	PROCEDURE InsertarFinal (VAR lista: tListasCircularesCabecera; e: tElemento);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListasCircularesCabecera);
		BEGIN
			lista.pri:=NIL;
			lista.ult:=NIL;
		END;
	PROCEDURE Construir (VAR lista: tListasCircularesCabecera; e: tElemento);
		VAR
			aux: tipoNodo;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			IF EsVacia (lista) THEN
				BEGIN
					lista.pri:=aux;
					aux^.sig:=aux;
					lista.ult:=aux;
				END
			ELSE
				BEGIN
					lista.ult^.sig:=aux;
					aux^.sig:=lista.pri;
					lista.ult:=aux;
				END;
		END;

	PROCEDURE Primero (lista: tListasCircularesCabecera; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				AsignarElemento (e, lista.pri^.info);
		END;
	PROCEDURE Resto (VAR lista: tListasCircularesCabecera);
		VAR
			aux: tipoNodo;
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					aux:=lista.pri;
					lista.pri:=lista.pri^.sig;
					lista.ult^.sig:=lista.pri;
					dispose(aux);
				END;
		END;
	PROCEDURE Ultimo (lista: tListasCircularesCabecera; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				AsignarElemento (e, lista.ult^.info);
		END;

	FUNCTION EsVacia (lista: tListasCircularesCabecera):boolean;
		BEGIN
			EsVacia:=((lista.pri = NIL) AND (lista.ult = NIL));
		END;
	FUNCTION Longitud (lista: tListasCircularesCabecera):integer;
		VAR
			i: integer;
			aux: tipoNodo;
		BEGIN
			i:=0;
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					aux:= lista.pri;
					REPEAT
						i:=i+1;
						aux:=aux^.sig;
					UNTIL (aux = lista.pri);
				END;
			Longitud:=i;
		END;
	FUNCTION Pertenece (lista: tListasCircularesCabecera; e: tElemento):boolean;
		VAR
			aux: tipoNodo;
		BEGIN
			IF EsVacia (lista) THEN
				Pertenece:=false
			ELSE
				BEGIN
					aux:=lista.pri;
					WHILE ((aux^.sig <> lista.pri) AND (aux^.info <> e)) DO
						aux:=aux^.sig;
					IF (aux^.info = e) THEN
						Pertenece:=true
					ELSE
						Pertenece:=false;
				END;
		END;
	PROCEDURE MostrarLista (lista: tListasCircularesCabecera);
		VAR
			aux: tipoNodo;
		BEGIN
			IF (EsVacia (lista)) THEN
				WRITELN ('La lista es vacia')
			ELSE
				BEGIN
					aux:=lista.pri;
					REPEAT
						WRITELN (aux^.info);
						aux:=aux^.sig;
					UNTIL (aux = lista.pri);
				END;
		END;

	PROCEDURE Concatenar (lista1, lista2: tListasCircularesCabecera; VAR lista3: tListasCircularesCabecera);
		VAR
			aux: tipoNodo;
		BEGIN
			IF EsVacia (lista1) THEN
				IF EsVacia (lista2) THEN
					CrearVacia (lista3)
				ELSE
					BEGIN
						aux:=lista2.pri;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista2.pri);
					END
			ELSE
				IF EsVAcia (lista2) THEN
					BEGIN
						aux:=lista1.pri;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista1.pri);
					END
				ELSE
					BEGIN
						aux:=lista1.pri;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista1.pri);
						aux:=lista2.pri;
						REPEAT
							Construir (lista3, aux^.info);
							aux:=aux^.sig;
						UNTIL (aux = lista2.pri);
					END;
		END;
	PROCEDURE BorrarElemento (VAR lista: tListasCircularesCabecera; e: tElemento);
		VAR
			aux, aux2: tipoNodo;
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				IF (lista.pri^.info = e) THEN
					BEGIN
						aux:=lista.pri;
						lista.ult^.sig:=lista.pri^.sig;
						lista.pri:=lista.pri^.sig;
						dispose(aux);
					END
				ELSE
					IF (lista.ult^.info = e) THEN
						BEGIN
							aux:=lista.ult;
							aux2:=lista.pri;
							REPEAT
								aux2:=aux2^.sig;
							UNTIL (aux2^.sig = lista.ult);
							aux2^.sig:=lista.pri;
							lista.ult:=aux2;
							dispose(aux);
						END
					ELSE
						BEGIN
							aux:=lista.pri;
							aux2:=NIL;
							WHILE ((aux^.info <> e) AND (aux^.sig <> lista.pri)) DO
								BEGIN
									aux2:=aux;
									aux:=aux^.sig;
								END;
							IF (aux^.info = e) THEN
								BEGIN
									aux2^.sig:=aux^.sig;
									dispose (aux);
								END;
						END;
		END;
	PROCEDURE InsertarFinal (VAR lista: tListasCircularesCabecera; e: tElemento);
		VAR
			aux: tipoNodo;
		BEGIN
			IF NOT (EsVacia (lista)) THEN
				BEGIN
					new (aux);
					AsignarElemento (aux^.info, e);
					aux^.sig:=lista.pri;
					lista.pri:=aux;
					lista.ult^.sig:=aux;
				END
			ELSE
				Construir (lista, e);
		END;

END.
