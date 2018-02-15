function[H,time,fn,h] = final_fftquiz(dt,T)
time = 0:dt:T;
n = length(time);

df = 1/T;
fn = (0:n-1)*df;
h = NaN(1,n);

for t = 1:n
    h(t) = sin(2*pi*time(t))^2;
end
plot(time,h)
H = abs(fft(h));
figure(2)
plot(H)
end