%hw use second order runge-kutta; redo euler
%prob 3.2 ne = time step per period (2*pi), amplitude = 1
    %tmid = tn + .5*dt
    %xmid = xn + vn*.5*dt
    %vmid = vn + f(xn, vn, tn)*.5*dt
    %dt = t(n+1) - tn
%Euler approx with Runge-Kutt
    %t(n+1) = tn +dt
    %x(n+1) = xn + vmid*dt
    %v(n+1) = vn + f(xmid, vmid, tmid)*dt

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

function a = acc(x,v,t)
    a = -x; %simple harmonic
end
    