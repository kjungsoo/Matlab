function fourierSeriesGraph(n,a,T)
%This function will hopefully graph the fourier series solution
%approximated to the indexes in n

n = -n:n;
a = (2/5) * sinc((2/5)*n);
T = 5;

dt = T/100;
t = -T/2:dt:3*T/2;

N = length(n);

x = 0;
for index = 1 : N
    x = x + a(index)*exp(1i*2*pi*n(index)*t/T);
end
plot(t,real(x))
end