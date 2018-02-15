function [] = prob3p2(Ne,Nr)
dt = (2*pi)/Nr;
dts = (2*pi)/Ne;
rungekutta(1,0,dt, 20*pi);
Euler(0,1,dts,20*pi);
end

function[x,v,t] = rungekutta(x0,v0,dt,T)
t = 0:dt:T;
N = length(t);
x = NaN(1,N);
v = NaN(1,N);
n = 1;
x(n) = x0;
v(n) = v0;
while n<N
    tmid = t(n) +.5*dt;
    vmid = v(n) + acc(x(n), v(n), t(n))*.5*dt;
    xmid = x(n) + v(n)*.5*dt;
    v(n+1) = v(n) + acc(xmid, vmid, tmid)*dt;
    x(n+1) = x(n) + vmid*dt;
    n = n + 1;
end
figure(2)
plot(t,v)
end

function [xs,vs,ts] = Euler(x0,v0, dts,T) %euler's method
ts = 0:dts:T;
N = length(ts);
xs = NaN(1,N);
vs = NaN(1,N);

n = 1;
xs(n) = x0;
vs(n) = v0;

while n<N
    vs(n+1) = vs(n) + acc(xs(n),vs(n),ts(n))*dts;
    xs(n+1) = xs(n) + vs(n)*dts;
    n = n + 1;
end
figure(1)
plot(ts,vs)
end


function a = acc(x,v,t)
    a = -x; %simple harmonic
end
    