function [y,v,P] = quiz(dt,T)
b = 16;
m = 200;
g = 9.81;
t = 0:dt:T;
N = length(t);
v = NaN(1,N);
y = NaN(1,N);
p = NaN(1,N);

n = 1;
v(n) = 0;
y(n) = 40000;
while n<N
    p(n) = (1.28)*exp(-y(n)/7840);
    v(n+1) = v(n) + acc(m,g,b,p(n),v(n))*dt;
    y(n+1) = y(n) + v(n)*dt;
    n = n + 1;
end
Fd = -b*p.*v;
P = Fd.*v;

figure(1)
plot(t,y);
figure(2)
plot(t,v);
figure(3)
plot(t,P);
end

function a = acc(m,g,b,p,v)
a = (-m*g - b*p.*v)/m;
end