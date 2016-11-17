function [ u_a, ceros ] = entrelaza( u, lb )

c = 0;
if (mod(length(u),lb)~=0)
   c = lb-mod(length(u),lb);
   fprintf('_');
   u = [u zeros(1,lb-mod(length(u),lb))];
end

N = length(u)/lb; %numero de bloques
u_a = reshape(reshape(u,N, lb)',1,length(u));
ceros = c;

end