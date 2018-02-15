function [psi_now] = testcalling(Nt,theta_incident)
% input used Snell(200,200,.1,.1,.1,45,1.5)
alphaTarget = 0.5;
theta_incident = theta_incident*pi/180; 
L = 1;

dx  = 1;
del = 45;
T = 20;
Rad = 200;
index_refrac = 1.5; 

[c,x,Nx,y,Ny] = make_mask(dx, del, Rad, T, index_refrac);

f   = zeros(Nx,Ny);
g   = zeros(Nx,Ny);
Lap = zeros(Nx,Ny);

dt = sqrt(alphaTarget)*dx/max(max(c));
alpha = (c*dt/dx).^2;
%theta_t = asin(sin(theta_incident)/index_refrac);

lambda = 10*dx;
k = (2*pi)/lambda;
kx_i = k*cos(theta_incident);
ky_i = k*sin(theta_incident);

for n = 2:Ny-1
    for m = 2:Nx-1
        r2 = (x(m)+3*del)^2 + y(n)^2;
        delta = exp(-r2/del^2);
        f(m,n) = delta*sin(kx_i*x(m)+ky_i*y(n));
        g(m,n) = -k*delta*cos(kx_i*x(m)+ky_i*y(n));
    end
end

psi_past = f;
psi_now = f + g*dt;
rx = 2:Nx-1;
ry = 2:Ny-1;

figure(2);
lim = max(max(abs(psi_now(rx,ry))));
imagesc(psi_past,[-lim,lim]);
pause(1.0);

for nt=1:Nt
    Lap(rx,ry) = psi_now(rx-1,ry)+psi_now(rx+1,ry)+psi_now(rx,ry-1)+psi_now(rx,ry+1)-4*psi_now(rx,ry);
    psi_future = 2*psi_now - psi_past + alpha.*Lap;
    psi_past = psi_now;
    psi_now = psi_future;
    
    lim = max(max(abs(psi_now(rx,ry))));
    figure(2)
    imagesc(psi_now,[-lim,lim]);
    pause(0.01);

end
    figure(3)
    surf(psi_now);
end