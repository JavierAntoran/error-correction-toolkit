function u = codificar_bch( m, n, k )
%function u = codificar_bch( m, n, k )
% Codifica un mensaje m utilizando un c�digo BCH (n,k). 
% Si no hay un n�mero exacto de bloques de tama�o k, rellena con ceros 
% hasta completar el �ltimo bloque.
% m:  mensaje a codificar, vector fila de valores 0 y 1
% n: n�mero de bits de la palabra c�digo
% k: n�mero de bits de cada bloque del mensaje
% u: mensaje codificado, vector fila de valores 0 y 1
