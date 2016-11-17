function [nerr,Pb] = calcular_errores(m, m_rec, u)
if( length(m) ~= length(m_rec))
    disp('warning mensajes con distinto número de bits');
end
if( length(m) > length(m_rec))
    error('error. mensaje recibido demasiado corto');
end

%--- número de errores

N = length(m);
nerr = length( find(m ~= m_rec(1:N)) );

Pb = nerr / N;

%--- cumple potencia ?

Rb = 1;
Tb = 1/Rb;
T  = Tb * length(m);
Rc = Rb * (length(u) / length(m));
Tc = 1/Rc;
Pt =  mean( (u.^2/Tc ) );

if( Pt < 1 + 1e-3)
    fprintf('Cumple Pt = %.3f <= 1 W\n',Pt);
else
    fprintf('No Cumple Pt = %.3f > 1 W\n',Pt);
end

