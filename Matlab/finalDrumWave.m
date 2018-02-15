function [psi_now] = finalDrumWave(N,M,Lx,Nt,alpha,f)
c = 1;
delta = Lx/(N-1);
rx = 2:N-1;
ry = 2:M-1;

dt = sqrt(alpha)*delta/c;

g   = zeros(N,M);
Lap = zeros(N,M);

psi_past = (2*sin((rx(1)*pi)/N)+sin((2*rx(1)*pi)/N))*sin((ry(1)*pi)/N);
psi_now  = f + g*dt;

figure(2);
lim = max(max(abs(psi_now(rx,ry))));
imagesc(psi_past,[-lim,lim]);
pause(1.0);

for nt=1:Nt
    Lap(rx,ry) = psi_now(rx-1,ry)+psi_now(rx+1,ry)+psi_now(rx,ry-1)+psi_now(rx,ry+1)-4*psi_now(rx,ry);
    psi_future = 2*psi_now - psi_past + alpha*Lap;
    psi_past = psi_now;
    psi_now = psi_future;
    
    lim = max(max(abs(psi_now)));
    figure(2)
    imagesc(psi_now,[-lim,lim]);
    pause(0.01);
end
    figure(3)
    surf(psi_now);

end