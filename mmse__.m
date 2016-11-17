clear all;
aprendizaje = 0.00007;
s = datos();
canal = @canal4;
Lent = length(s);
N = 51;


xent = s;
xent(xent == 0) = -1;

rent = canal(xent); %senal a la salida del canal



%entrena

r1 = [zeros(1, N-1) rent];
x1 = [zeros(1, (N-1)/2) xent];

errores1 = zeros(1, Lent);
c = zeros(1,N);


for i = 1:Lent
    
    rk = (r1(i:i+N-1));
    
    zk1 = dot(c, rk); %prediccion
    
    d1 = x1(i);% retardo sobre senal recibida
    
    e = d1 - zk1; %error = llegado - estimacion 
    
    %atento a desplazamiento temporal filtro
    c = c + aprendizaje*e*rk; % atento al signo 

    errores1(i) = e;
end

%plot((errores1).^2);

c = c;
zk = zeros(1,Lent+(N-1)/2);
r2 = [zeros(1, N-1) rent(1:end) zeros(1,(N-1)/2)];

for i = 1:Lent
    
    rk = (r2(i:i+N-1));
    
    zk(i) = dot(c, rk); %prediccion
    
    zkd = sign(zk(i)+eps);
    
    
    e = zkd - zk(i); %error = llegado - estimacion 
    
   %atento a desplazamiento temporal filtro
   if i > N
       c = c + aprendizaje*e*rk; % atento al signo 
   end;
   
   
   errores2(i) = e;
end

out = zk((N+1)/2:end);

ru = sign(out-eps);
ru(ru==-1) = 0;

er = calcular_errores(s, ru, xent);
er/Lent
%%
load('21coefsMMSE.mat');
c = fliplr(c);
zh = conv(rent, c, 'same');

zh = sign(zh + eps);
zh(zh==-1) = 0;

er = calcular_errores(s, zh, xent);
er/Lent