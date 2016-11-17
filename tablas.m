function [tabla_in,tabla_out] = tablas(g1,g2)
tabla_in=zeros(2^(length(g1)),length(g1));
tabla_out=zeros(2^(length(g1)),length(g1)+1);
bit=0;
output=zeros(1,2);
k=length(g1)-1;%donde k es el número de bits de estado
estados=zeros(2^k,k);
for l=1:2^k
   estados(l,1:end)=dec2bin(l-1,k)-'0';
end

pos_estado=1;

for i=1:(2^(length(g1)))
    if bit==0
    estado=estados(pos_estado,1:end);
    pos_estado=pos_estado+1;
    end
    tabla_in(i,1:end)=[bit estado];
    output(1)=mod(g1*tabla_in(i,1:end)',2);
    output(2)=mod(g2*tabla_in(i,1:end)',2);
    tabla_out(i,1:end)=[tabla_in(i,1:k) output(1) output(2)]; 
    bit=not(bit);
end
    
    
    

