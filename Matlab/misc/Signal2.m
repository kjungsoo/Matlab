function Signal2(fs)
% Homework Problem 5.6
% 05.11.2015

% fs = 1/dt
% dt = 1/fs
% fn = n*df
% df = 1/T

% (a) Signal2(2000)
% (b) Signal2(3000)
% (c) Signal2(1000)

T  = 0.01;
N  = 20;
dt = T/N;
% df = 1/T;
t = (0:N-1)*dt;
% f  = (0:N-1)*df;

h = cos(2*pi*(2100-fs)*t)+2*cos(2*pi*(2200-fs)*t)+3*cos(2*pi*(2300-fs)*t);

figure(1)
plot(t,abs(fft(h)));

end