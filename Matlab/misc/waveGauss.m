function [psi_now] = waveGauss(N,Nt,R,a,b,theta_incident,index_refrac)
theta_incident = theta_incident*pi/180;
M = N;
L = 1;
alphaTarget = 0.5;

dx = L/(N-1);
dy = L/(M-1);

%alpha = 0.5;  %alpha (c*dt/dx)^2;  This is a way of choosing dt.
%dt = sqrt(alphaTarget)*dx/c;

% set initial condition

f   = zeros(N,M);
g   = zeros(N,M);
Lap = zeros(N,M);
%k = (2*pi)/(10*dx);

c = ones(N,M);
c(round(N/2):N,:) = 1/index_refrac;

dt = sqrt(alphaTarget)*dx/max(max(c));
alpha = (c*dt/dx).^2;
theta_t = asin(sin(theta_incident)/index_refrac);

lambda = 10*dx;
k = (2*pi)/lambda;
kx_i = k*cos(theta_incident);
ky_i = k*sin(theta_incident);

kx_t = k*cos(theta_t);
ky_t = k*sin(theta_t);

for n = 2:N-1;
    x = (n-1)*dx;
    for m = 2:M-1
        y = (m-1)*dy;
        r2 = (x-a*L)^2 + (y-b*L)^2;
        delta = exp(-r2/R^2);
        if c(n,m) == 1
            f(n,m) = delta*sin(kx_i*x+ky_i*y);
            g(n,m) = -k*delta*cos(kx_i*x+ky_i*y);
        else
            f(n,m) = delta*sin(kx_t*x+ky_t*y);
            g(n,m) = -k*delta*cos(kx_t*x+ky_t*y);
        end
    end
end

psi_past = f;
psi_now   = f + g*dt;
rx = 2:N-1;
ry = 2:M-1;

figure(2);
lim = max(max(abs(psi_now(rx,ry))));
imagesc(psi_past,[-lim,lim]);
pause(1.0);

for nt=1:Nt
%     for n = 2:N-1;
%         for m = 2:M-1
%             laplace = f(n-1,m)+f(n+1,m)+f(n,m-1)+f(n,m+1)-4*f(n,m);
%         end
%     end
    Lap(rx,ry) = psi_now(rx-1,ry)+psi_now(rx+1,ry)+psi_now(rx,ry-1)+psi_now(rx,ry+1)-4*psi_now(rx,ry);
    psi_future = 2*psi_now - psi_past + alpha.*Lap;
    psi_past = psi_now; % update what is psi_n-1 and psi_n
    psi_now = psi_future;
    
    lim = max(max(abs(psi_now(rx,ry))));
    figure(2)
    imagesc(psi_now,[-lim,lim]);
    pause(0.01);
%     figure(3)
%     surf(psi);
%     input('go?');

end
    figure(3)
    surf(psi_now);

end