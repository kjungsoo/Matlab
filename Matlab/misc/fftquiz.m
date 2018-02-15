function[H,time,fn,h] = fftquiz(dt,T)
time = 0:dt:T;
n = length(time);

df = 1/T;
fn = (0:n-1)*df;
h = NaN(1,n);

for t = 1:n
    h(t) = -cos(2*pi*time(t));
    if h(t) < 0
        h(t) = 0;
    end
end
plot(time,h)
H = fft(h);

end