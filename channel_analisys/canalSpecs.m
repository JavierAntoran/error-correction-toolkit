function[] = canalSpecs(canal)

%calculos

L = 10e5;

seno = sin(1:L);
pulso = ones(1,L);
null = zeros(1,L);
delt = [null(1:L/2-1) 1 null(1:L/2)];
ran = 2*rand(1,L)-1;

cPulso = canal(pulso);
cnull = canal(null);
cdelta = canal(delt);
crand = canal(ran);
csin = canal(seno);

rand('seed', 4352);

cPulso2 = canal(pulso);
cnull2 = canal(null);
cdelta2 = canal(delt);

t1 = max(abs(cPulso - cPulso2));
t2 = max(abs(cnull - cnull2));
t3 = max(abs(cdelta - cdelta2));
tsum = t1+t2+t3;

atenuacion  = mean(pulso)/mean(cPulso-cnull);

maxerror = max(abs(cnull));
minerror = min(abs(cnull));
avgerror = mean(abs(cnull));

checkisi = (crand-cnull-ran);
maxcheckisi = max(abs(checkisi));


isi = cdelta-cnull;


% salidas 
if (tsum < 10^-5)
    
    fprintf('canal NO aleatorio\n')
    fprintf('3x total diferencia cambiando seed: %d\n', tsum);
else
    fprintf('canal aleatorio\n')
    fprintf('t1: %d\n', t1);
    fprintf('t2: %d\n', t2);
    fprintf('t3: %d\n', t3);
end;
    
fprintf('atenuacion = %d\n', atenuacion);
fprintf('maxerror =  %d\n', maxerror);
fprintf('minerror =  %d\n', minerror);
fprintf('avgerror =  %d\n', avgerror);
fprintf('hay ISI?? max isi en rand =  %d\n', maxcheckisi);

subplot(1,2,1)
plot(isi);
grid on
title('resp imp en tiempo');
subplot(1,2,2)
plot(fftshift(abs(fft(isi))))
grid on
title('resp imp en frecuencia');

sum(isi ~= 0)

figure
subplot(2,1,1)
plot(cnull);
grid on
title('ruido en tiempo');
ylabel('amplitud');
subplot(2,1,2)
%cnullmod = cnull(cnull>0.8); En el canal dos, quitar energia a errores de
%baja amplitud para observar pico de alta amplitud enmascarado alrededor de
%frecuencias bajas.
plot(fftshift(10*log10(abs(fft(xcorr(cnull)))))); 
title('DEP ruido en frecuencia');
ylabel('10log10');


figure
plot(checkisi)
ylabel('ATENTO A LA ESCALA');
grid on
title('interferencias no causadas por ruido');

%cosas extra
figure
plot(csin-cnull)
title('isi a seno')

end