/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uColas;
INTERFACE
	USES uElemTAD;
	TYPE
		tColas = ^tNodo;
		tNodo = RECORD
			info: tElemento;
			sig: tColas;
		END;

	PROCEDURE CrearVacia (VAR cola: tColas);
	PROCEDURE Construir (VAR cola: tColas; e: tElemento);

	PROCEDURE Primero (cola: tColas; VAR e: tElemento);
	PROCEDURE Resto (VAR Cola: tColas);
	PROCEDURE Ultimo (cola: tColas; VAR e: tElemento);

	FUNCTION EsVacia (cola: tColas):boolean;
	FUNCTION Longitud (cola: tColas):integer;
	FUNCTION Pertenece (cola: tColas; e: tElemento):boolean;
	PROCEDURE MostrarCola (cola: tColas);

	PROCEDURE Concatenar (cola1, cola2: tColas; VAR cola3: tColas);
	PROCEDURE BorrarElemento (VAR cola: tColas);

IMPLEMENTATION
	PROCEDURE CrearVacia (VAR cola: tColas);
		BEGIN
			cola:= NIL;
		END;

	PROCEDURE Construir (VAR cola: tColas; e: tElemento);
		VAR
			aux, aux2: tColas;
		BEGIN
			new (aux);
			AsignarElemento (aux^.info, e);
			IF (EsVacia (cola)) THEN
				BEGIN
					aux^.sig:=cola;
					cola:=aux;
				END
			ELSE
				BEGIN
					aux2:=cola;
					WHILE (aux2^.sig <> NIL) DO
						aux2:=aux2^.sig;
					aux2^.sig:=aux;
					aux^.sig:=NIL;
				END;
		END;

	PROCEDURE Primero (cola: tColas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (cola)) THEN
				AsignarElemento (e, cola^.info);
		END;

	PROCEDURE Resto (VAR Cola: tColas);
		VAR
			aux: tColas;
		BEGIN
			IF NOT (EsVacia (cola)) THEN
				BEGIN
					aux:=cola;
					cola:=cola^.sig;
					dispose (aux);
				END;
		END;

	PROCEDURE Ultimo (cola: tColas; VAR e: tElemento);
		BEGIN
			IF NOT (EsVacia (cola)) THEN
				BEGIN
					WHILE (cola^.sig <> NIL) DO
						cola:=cola^.sig;
					AsignarElemento (e, cola^.info);
				END;
		END;

	FUNCTION EsVacia (cola: tColas):boolean;
		BEGIN
			EsVacia:=(cola = NIL);
		END;

	FUNCTION Longitud (cola: tColas):integer;
		VAR
			i: integer;
		BEGIN
			i:=0;
			IF NOT (EsVacia (cola)) THEN
				BEGIN
					WHILE (cola <> NIL) DO
						BEGIN
							i:=i+1;
							cola:=cola^.sig;
						END;
				END;
			Longitud:=i;
		END;

	FUNCTION Pertenece (cola: tColas; e: tElemento):boolean;
		VAR
			valor: boolean;
		BEGIN
			IF (EsVacia (cola)) THEN
				valor:=false
			ELSE
				BEGIN
					WHILE ((cola^.sig <> NIL) AND (cola^.info <> e)) DO
						cola:=cola^.sig;
					IF (cola^.info = e) THEN
						valor:=true;
				END;
			Pertenece:=valor;
		END;

	PROCEDURE MostrarCola (cola: tColas);
		BEGIN
			IF EsVacia (cola) THEN
				WRITELN ('La cola esta vacia')
			ELSE
				WHILE (cola <> NIL) DO
					BEGIN
						WRITELN (cola^.info);
						cola:=cola^.sig;
					END;
		END;

	PROCEDURE Concatenar (cola1, cola2: tColas; VAR cola3: tColas);
		BEGIN
			IF (EsVacia (cola1)) THEN
				IF (EsVacia (cola2)) THEN
					CrearVacia (cola3)
				ELSE
					WHILE (cola2 <> NIL) DO
						BEGIN
							Construir (cola3, cola2^.info);
							cola2:=cola2^.sig;
						END
			ELSE
				IF (EsVacia (cola2)) THEN
					WHILE (cola1 <> NIL) DO
						BEGIN
							Construir (cola3, cola1^.info);
							cola1:=cola1^.sig;
						END
				ELSE
					BEGIN
						WHILE (cola1 <> NIL) DO
							BEGIN
								Construir (cola3, cola1^.info);
								cola1:=cola1^.sig;
							END;
						WHILE (cola2 <> NIL) DO
							BEGIN
								Construir (cola3, cola2^.info);
								cola2:=cola2^.sig;
							END;
					END;
		END;

	PROCEDURE BorrarElemento (VAR cola: tColas);
		VAR
			aux: tColas;
		BEGIN
			IF NOT (EsVacia (cola)) THEN
				BEGIN
					aux:=cola;
					cola:=cola^.sig;
					dispose (aux);
				END;
		END;
END.
