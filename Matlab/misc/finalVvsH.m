function finalVvsH()
dt = 0.1;
v0 = 0:dt:50;
h = NaN(1,length(v0));
hg = NaN(1, length(v0));

g = -9.81;

n=1; 
while n < length(v0)
    h(n) = finalEuler(v0(n), dt);
    n = n+1;
    hg(n) = v0(n)^2 / (2*g);
end
figure(2)
plot(v0, h)
figure(3)
plot(hg)
end