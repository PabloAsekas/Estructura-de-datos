/*

Código realizado por Pablo Bermejo

https://github.com/PabloAsekas/

*/

UNIT uElemTAD;
INTERFACE
	TYPE
		tElemento = integer;

	{Constructoras generadoras}
	PROCEDURE AsignarElemento (VAR e, e1: tElemento);
	FUNCTION SonIguales (e, e1: tElemento):boolean;

IMPLEMENTATION
	PROCEDURE AsignarElemento (VAR e, e1: tElemento);
		BEGIN
			e:=e1;
		END;

	FUNCTION SonIguales (e, e1: tElemento):boolean;
		BEGIN
			SonIguales:=(e=e1);
		END;

END.
