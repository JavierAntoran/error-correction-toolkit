function [ m ] = desentrelaza( u, lb, ceros )

N = length(u)/lb; %numero de bloques

if mod(N,1) ~= 0;
    fprintf('dimensiones de entrelazado no coinciden');
else
    
    m = reshape(reshape(u, lb, N)',1,length(u));
    m = m(1:end-ceros);

end

