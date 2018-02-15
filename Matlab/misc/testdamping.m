function[amp] = testdamping(v0,y0,w,T)
m = 2;
k = 72;
b = 0.4;
f = 3;
dt = 0.01;
t = 0:dt:T;
N = length(t);
v = NaN(1,N);
x = NaN(1,N);

n = 1;
v(n) = v0;
x(n) = y0;

tmax = NaN(1,T);
count = 0;
diff = 1;

while n<N && diff > 0.0001
    tmid = t(n) +.5*dt;
    vmid = v(n) + acc(k,x(n),b,v(n),f,w,t(n),m)*.5*dt;
    xmid = x(n) + v(n)*.5*dt;
    v(n+1) = v(n) + acc(k,xmid,b,vmid,f,w,tmid,m)*dt;
    x(n+1) = x(n) + vmid*dt;
    if v(n+1) < 0 && v(n) > 0
        count = count + 1;
        tmax(count) = x(n);
    end
    if count > 1 && count < length(tmax)
        diff = abs(tmax(count)-tmax(count-1))/tmax(count);
    end
    n = n + 1;
end
amp = tmax(count);
figure(1)
plot(t,x);
%figure(2)
%plot(tmax);
end

function a = acc(k,x,b,v,f,w,t,m)
a = (-k*x - b*v + f*sin(w*t))/m;
end