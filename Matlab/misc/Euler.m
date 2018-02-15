function [ys,vs,ts] = finalEuler(v0, dt,T) %euler's method
ts = 0:dt:T;
N = length(ts);
ys = NaN(1,N);
vs = NaN(1,N);

n = 1;
ys(n) = 0;
vs(n) = v0;

while n<N
    vs(n+1) = vs(n) + acc(v(n))*dt;
    ys(n+1) = ys(n) + vs(n)*dt;
    n = n + 1;
end
figure(1)
plot(ts,vs)
end

function A = acc(v)
    m = 2;
    b = 1.8;
    g = -9.8;
    A = g + (b*v)/m;
end
    