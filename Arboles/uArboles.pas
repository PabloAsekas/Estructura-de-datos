/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uArboles;
INTERFACE
	USES uElemTAD;

	TYPE
		tArbol: ^tNodo;
		tNodo = RECORD
			info: tElemento;
			izq, der: tArbol;
		END;

	PROCEDURE CrearVacio (VAR arbol: tArbol);
	PROCEDURE Construir (VAR arbol: tArbol; izq, der: tArbol; e: tElemento);

	FUNCTION EsVacio (arbol: tArbol): boolean;

	FUNCTION Raiz (arbol: tArbol):tElemento
	PROCEDURE Izq (arbol: tArbol; VAR izq: tArbol);
	PROCEDURE Der (arbol: tArbol; VAR der: tArbol);

	FUNCTION NumNodos (arbol: tArbol):integer;
	FUNCTION NumHojas (arbol: tArbol):integer;
	FUNCTION Altura (arbol: tArbol):integer;
	FUNCTION Compensado (arbol: tArbol):boolean;
	FUNCTION NivelElemento (arbol: tArbol; e: tElemento):integer;
	FUNCTION ExisteElemento (arbol: tArbol; e: tEelemento):boolean;
	PROCEDURE MostrarPreorden (arbol: tArbol);
	PROCEDURE MostrarInorden (arbol: tArbol);
	PROCEDURE MostrarPostOrden (arbol: tArbol);

IMPLEMENTATION
	PROCEDURE CrearVacio (VAR arbol: tArbol);
		BEGIN
			arbol:=NIL;
		END;

	PROCEDURE Construir (VAR arbol: tArbol; izq, der: tArbol; e: tElemento);
		BEGIN
			new(arbol);
			AsignarElemento (arbol^.info, e);
			arbol^.izq:=izq;
			arbol^.der:=der;
		END;

	FUNCTION EsVacio (arbol: tArbol): boolean;
		BEGIN
			EsVacio:=(arbol = NIL);
		END;

	FUNCTION Raiz (arbol: tArbol):tElemento
		BEGIN
			IF NOT EsVacio (arbol) THEN
				AsignarElemento (Raiz, arbol^.info);
		END;

	PROCEDURE Izq (arbol: tArbol; VAR izq: tArbol);
		BEGIN
			IF NOT EsVacio (arbol) THEN
				izq:=arbol^.izq;
		END;

	PROCEDURE Der (arbol: tArbol; VAR der: tArbol);
		BEGIN
			IF NOT EsVacio (arbol) THEN
				der:=arbol^.der;
		END;

	FUNCTION NumNodos (arbol: tArbol):integer;
		VAR
			izq, der: tArbol;
		BEGIN
			IF EsVacio (arbol) THEN
				NumNodos:=0
			ELSE
				BEGIN
					Izq (arbol, izq);
					Der (arbol, der);
					NumNodos := (NumNodos (izq) + NumNodos (der) + 1);
				END;
		END;

	FUNCTION NumHojas (arbol: tArbol):integer;
		VAR
			der, izq: tArbol;
		BEGIN
			IF EsVacio (arbol) THEN
				NumHojas:=0
			ELSE
				IF ((arbol^.der = NIL) AND (arbol^.izq = NIL)) THEN
					NumHojas:=1
				ELSE
					BEGIN
						Izq (arbol, izq);
						Der (arbol, der);
						NumHojas (NumHojas (izq) + NumHojas (der));
					END;
		END;

	FUNCTION Altura (arbol: tArbol):integer;
		VAR
			izq, der: tArbol;
			i, d: integer;
		BEGIN
			IF EsVacio (arbol) THEN
				Altura:=0
			ELSE
				BEGIN
					Izq (arbol, izq);
					Der (arbol, der);
					i:=Altura (izq);
					d:=Altura (der);
					IF i < d THEN
						Altura:=i+1
					ELSE
						Altura:=d+1;
				END;
		END;

	FUNCTION Compensado (arbol: tArbol):boolean;
		VAR
			izq, der: tArbol;
		BEGIN
			IF EsVacio (arbol) THEN
				Compensado:=TRUE
			ELSE
				BEGIN
					Der (arbol, der);
					Izq (arbol, izq);
					Compensado := (NumNodos (der) = NumNodos (izq));
				END;
		END;

	FUNCTION NivelElemento (arbol: tArbol; e: tElemento):integer;
		VAR
			der, izq: tArbol;
		BEGIN
			IF NOT ExisteElemento (arbol, e) THEN
				NivelElemento:=0
			ELSE
				IF (Raiz (arbol) = e) THEN
					NivelElemento:=1
				ELSE
					BEGIN
						Izq (arbol, izq);
						Der (arbol, der);
						IF NivelElemento (izq, e) > Nivelelemento (der, e) THEN
							NivelElemento:=	1+NivelElemento (izq, e)
						ELSE
							Nivelelemento:= 1+NivelElemento (der, e);
					END;
		END;

	FUNCTION ExisteElemento (arbol: tArbol; e: tEelemento):boolean;
		VAR
			der, izq: tArbol;
		BEGIN
			IF EsVacio (arbol) THEN
				ExisteElemento:=FALSE
			ELSE
				IF (Raiz (arbol) = e) THEN
					ExisteElemento:=TRUE
				ELSE
					BEGIN
						Izq (arbol, izq);
						Der (arbol, der);
						ExisteElemento:=(ExisteElemento (izq, e) OR ExisteElemento (der, e));
					END;
		END;

	PROCEDURE MostrarPreorden (arbol: tArbol);
		VAR
			der, izq: tArbol;
		BEGIN
			IF NOT EsVacia (arbol) THEN
				BEGIN
					WRITELN (Raiz (arbol));
					Izq (arbol, izq);
					Der (arbol, der);
					MostrarPreorden (izq);
					MostrarPreorden (der);
				END;
		END;

	PROCEDURE MostrarInorden (arbol: tArbol);
		VAR
			der, izq: tArbol;
		BEGIN
			IF NOT EsVacia (arbol) THEN
				BEGIN
					Izq (arbol, izq);
					Der (arbol, der);
					MostrarInorden (izq);
					WRITELN (Raiz (arbol));
					MostrarInorden (der);
				END;
		END;

	PROCEDURE MostrarPostorden (arbol: tArbol);
		VAR
			der, izq: tArbol;
		BEGIN
			IF NOT EsVacia (arbol) THEN
				BEGIN
					Izq (arbol, izq);
					Der (arbol, der);
					MostrarPostorden (izq);
					MostrarPostorden (der);
					WRITELN (Raiz (arbol));
				END;
		END;
END.
