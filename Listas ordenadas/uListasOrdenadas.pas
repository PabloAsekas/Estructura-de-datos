/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uListasOrdenadas;
INTERFACE
	USES uElemTAD;
	TYPE
		tListaOrdenada = ^TipoNodo;
		TipoNodo = RECORD
			info: tElemento;
			sig: tListaOrdenada;
		END;

	PROCEDURE CrearVacia (VAR lista: tListaOrdenada);
	PROCEDURE Construir (VAR lista: tListaOrdenada; e: tElemento);

	PROCEDURE Primero (lista: tListaOrdenada; VAR e: tElemento);
	PROCEDURE Resto (VAR lista: tListaOrdenada);
	PROCEDURE Ultimo (lista: tListaOrdenada; VAR e: tElemento);

	FUNCTION EsVacia (lista: tListaOrdenada):boolean;
	FUNCTION Longitud (lista: tListaOrdenada):integer;
	FUNCTION Pertenece (lista: tListaOrdenada; e: tElemento):boolean;
	PROCEDURE MostrarLista (lista: tListaOrdenada);

	PROCEDURE Concatenar (lista1, lista2: tListaOrdenada; VAR lista3: tListaOrdenada);
	PROCEDURE BorrarElemento (VAR lista: tListaOrdenada; e: tElemento);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR lista: tListaOrdenada);
		BEGIN
			lista:=NIL;
		END;
	PROCEDURE Construir (VAR lista: tListaOrdenada; e: tElemento);
		VAR
			aux, aux2, aux3: tListaOrdenada;
		BEGIN
			new(aux);
			AsignarElemento(aux^.info, e);
			IF (EsVacia(lista)) THEN
				BEGIN
					aux^.sig:=lista;
					lista:=aux;
				END
			ELSE
				BEGIN
					aux2:=NIL;
					aux3:=lista;
					WHILE (aux3^.info > e) AND (aux3^.sig <> NIL) DO
						BEGIN
							aux2:=aux3;
							aux3:=aux3^.sig;
						END;
					IF (aux2 = NIL) THEN
						BEGIN
							lista:=aux;
							aux^.sig:=aux3;
						END
					ELSE
						IF (aux3^.sig = NIL) THEN
							BEGIN
								aux3:=aux;
								aux^.sig:=NIL;
							END
						ELSE
							BEGIN
								aux2^.sig:=aux;
								aux^.sig:=aux3;
							END;
				END;
{					new(aux);
					AsignarElemento(aux^.info, e);
					aux2:=lista;
					aux3:=lista^.sig;
					IF (aux2^.info > e) THEN
						BEGIN
							aux^.sig:=aux2;
							lista:=aux;
						END
					ELSE
						BEGIN
							WHILE ((aux3^.info < e) AND (aux3^.sig <> NIL)) DO
								BEGIN
									aux3:=aux3^.sig;
									aux2:=aux2^.sig;
								END;
							IF aux3^.sig = NIL THEN
								BEGIN
									aux3^.sig:=aux;
									aux^.sig:=NIL;
								END
							ELSE
								BEGIN
									aux2^.sig:=aux;
									aux^.sig:=aux3;
								END;
						END;
				END;}
		END;
	PROCEDURE Primero (lista: tListaOrdenada; VAR e: tElemento);
		BEGIN
			AsignarElemento (e, lista^.info);
		END;
	PROCEDURE Resto (VAR lista: tListaOrdenada);
		VAR
			aux: tListaOrdenada;
		BEGIN
			aux:=lista;
			lista:=aux^.sig;
			dispose(aux);
		END;
	PROCEDURE Ultimo (lista: tListaOrdenada; VAR e: tElemento);
		BEGIN
			WHILE (lista^.sig <> NIL) DO
				lista:=lista^.sig;
			AsignarElemento(e, lista^.info);
		END;
	FUNCTION EsVacia (lista: tListaOrdenada):boolean;
		BEGIN
			EsVacia:=(lista = NIL);
		END;
	FUNCTION Longitud (lista: tListaOrdenada):integer;
		VAR
			valor: integer;
		BEGIN
			IF EsVacia(lista) THEN
				valor:=0
			ELSE
				BEGIN
					valor:=0;
					WHILE lista <> NIL DO
						BEGIN
							lista:=lista^.sig;
							valor:=valor+1;
						END;
				END;
			Longitud:=valor;
		END;
	FUNCTION Pertenece (lista: tListaOrdenada; e: tElemento):boolean;
		VAR
			variable: boolean;
		BEGIN
			variable:=false;
			WHILE (lista^.info <> e) AND (lista^.sig <> NIL) DO
				lista:=lista^.sig;
			IF (lista^.info = e) THEN
				variable:=true;
			Pertenece:=variable;
		END;
	PROCEDURE MostrarLista (lista: tListaOrdenada);
		VAR
			aux: tListaOrdenada;
		BEGIN
			new(aux);
			aux:=lista;
			REPEAT
				WRITELN(aux^.info);
				aux:=aux^.sig;
			UNTIL (aux = NIL);
		END;
	PROCEDURE Concatenar (lista1, lista2: tListaOrdenada; VAR lista3: tListaOrdenada);
		BEGIN
			CrearVacia(lista3);
			WHILE (lista1^.sig <> NIL) DO
				BEGIN
					Construir(lista3, lista1^.info);
					lista1:=lista1^.sig;
				END;
			WHILE (lista2^.sig <> NIL) DO
				BEGIN
					Construir(lista3, lista2^.info);
					lista2:=lista2^.sig;
				END;
		END;
	PROCEDURE BorrarElemento (VAR lista: tListaOrdenada; e: tElemento);
		VAR
			aux, aux2: tListaOrdenada;
		BEGIN
			aux:=NIL;
			aux2:=lista;
			WHILE ((aux2^.info <> e) AND (aux2^.sig <> NIL)) DO
				BEGIN
					aux:=aux2;
					aux2:=aux2^.sig;
				END;
			IF (aux = NIL) THEN
				Resto(lista)
			ELSE
				IF (aux2^.info = e) THEN
					BEGIN
						aux^.sig:=aux2^.sig;
						dispose(aux2);
					END;
		END;
END.
