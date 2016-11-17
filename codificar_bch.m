function u = codificar_bch( m, n, k )
%function u = codificar_bch( m, n, k )
% Codifica un mensaje m utilizando un código BCH (n,k). 
% Si no hay un número exacto de bloques de tamaño k, rellena con ceros 
% hasta completar el último bloque.
% m:  mensaje a codificar, vector fila de valores 0 y 1
% n: número de bits de la palabra código
% k: número de bits de cada bloque del mensaje
% u: mensaje codificado, vector fila de valores 0 y 1
