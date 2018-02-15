function period(x0,dt,T,order)
N = round(T/dt);
t = NaN(1,N);
x = NaN(1,N);
v = NaN(1,N);

t(1) = 0;
x(1) = x0;
v(1) = 0;

par = 0;
n = 1;
while n<N
    [x(n+1),v(n+1),t(n+1)] = rkStep(x(n),v(n),t(n),dt,par,order);
    if x(n+1) < 0 && x(n) >0
        count = count + 1;
        crossing(count) = t(n);
        tn = (tn + (t(n+1))/(tn-t(1)));
    end
    n = n+1;
end

period = (crossing(count)-crossing(1)/(count-1));
figure(1)
plot(t/(2*pi),x)
hold on;
plot(crossing/(2*pi),zeros(1,count),'ro')
hold off;
end