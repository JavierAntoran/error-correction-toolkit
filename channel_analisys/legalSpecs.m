function [  ] = legalSpecs( canal )

L = 10e5;

resp = corrSec(canal);
t = 1:length(resp);
subplot(2,1,1)
stem(t,resp);
xlim([1, 100]);
grid on
title('resp imp en tiempo');
subplot(2,1,2)
plot(t,fftshift(abs(fft(resp))))
xlim([1, 100]);
grid on
title('resp imp en frecuencia');


null = zeros(1,L);
cnull = canal(null);


figure
subplot(2,1,1)
plot(cnull);
grid on
title('ruido promedio en tiempo');
ylabel('amplitud');
subplot(2,1,2)
plot(fftshift(10*log10(abs(fft(xcorr(cnull)))))); 
title('DEP ruido promedio en frecuencia');
ylabel('10log10');

end

