function m_out_decoded = decodificar_convolucional_soft(r, tabla_in, tabla_out, amplitud, debug)
%function m_out_decoded = decodificar_convolucional(r, tabla_in, tabla_out)
% Decodifica el mensaje recibido r con un código convolucional que
% viene definido por la tabla de verdad contenida en las variables 
% tabla_in y tabla_out con el algoritmo de Viterbi con distancia de
% Hammning.
% r: mensaje recibido, vector fila de valores 0 y 1
% tabla_in: entradas de la tabla de verdad
% tabla_out: salidas de la tabla de verdad
% debug: activa el modo de visualización
% m_out_decoded: mensaje recuperado, vector fila de valores 0 y 1

if( nargin == 3)
    debug = 0;
end

if(debug)
  print_tabla_verdad(tabla_in, tabla_out);
end


K       = size(tabla_in,2);
estados = 2^(K-1);         % número de estados

T = length(r)/2;

z1 = r(1:2:end);
z2 = r(2:2:end);


Dmax  = -Inf * ones(estados,T+1);
Qbest = -1*amplitud  * ones(estados,T+1);%menos
M     = 0  * ones(estados,T+1);%menos

[tabla_u1, tabla_u2, tabla_qnew] = crear_tablas(tabla_in, tabla_out);

Dmax(1,1) = 0;
     
for t=1:T
    for q = 1:estados
        for m = [0 1]
            
            u1 = tabla_u1(m+1,q);
            u2 = tabla_u2(m+1,q);
            
            u2(u2==1) = 1/amplitud;
            u1(u1==1) = 1/amplitud;
            u2(u2==0) = -1/amplitud;
            u1(u1==0) = -1/amplitud;
            
            u1u2 = [u1 u2];
            
            z1z2 = [z1(t) z2(t)];
            
            dist = sum( u1u2 .* z1z2);
         
            qnew = tabla_qnew(m+1,q);
            
            Dnew = Dmax(q,t) + dist;
            
            if( Dnew > Dmax(qnew,t+1) )
                Dmax(qnew,t+1)  = Dnew;
                Qbest(qnew,t+1) = q;
                M(qnew,t+1)     = m;
            end            
        end
    end
end

qbest(T+1) = 1; %%duda

m_out(T) = M(1,T+1);

for t=T:-1:2
    
    qbest(t) = Qbest( qbest(t+1), t+1);
    
    m_out(t-1) = M(qbest(t),t);

end
qbest(t-1) = Qbest( qbest(t), t);

%fprintf(1,'Dmin(T) = %d\n',Dmin(1,T+1));

m_out_decoded = m_out(1:end-K+1);

end




%------------------------------------------------------------------------
function [tabla_u1, tabla_u2, tabla_qnew] = crear_tablas(tabla_in, tabla_out)
K       = size(tabla_in,2);
estados = 2^(K-1); 

tabla_qnew = zeros(2, estados);
tabla_u1   = zeros(2, estados);
tabla_u2   = zeros(2, estados);

for q = 1:estados
for m = [0 1]
    q1q2   = de2bi(q-1,'left-msb',K-1);
    m_q1q2 = [ m q1q2 ];
   
    ifila    = indice_fila( tabla_in, m_q1q2 );
    
    q1q2_new = tabla_out(ifila,1:K-1);
    u1       = tabla_out(ifila,end-1);
    u2       = tabla_out(ifila,end);
    qnew = bi2de(q1q2_new,'left-msb') + 1;
    
    tabla_qnew(m+1,q) = qnew;
    tabla_u1(m+1,q) = u1;
    tabla_u2(m+1,q) = u2;
end
end

end
%------------------------------------------------------------------------
function indice = indice_fila(tabla, fila)
    indice = 0;
    for i=1:size(tabla,1)
        if( tabla(i,:) == fila)
            indice = i;
            return
        end
    end
end 
    


