function quiz2(threshold,Nblock)
Nx = 5*Nblock+2;
Ny = 7*Nblock+2;
Th = 1;
Tc = 0;
right = +1+1i;
left = -1+1i;
up = -1+2i;
down = +1+2i;

T = zeros(Ny,Nx) + (Th+Tc)/2;
Mask = zeros(Ny,Nx) + (0-1i);

Mask(:,1) = right;
Mask(:,Nx) = left;
Mask(1,:) = down;
Mask(Ny,:) = up;

rng = 1:Nblock;
Mask(rng+1,rng+1) = Th+0i;
Mask(rng+1,rng+1+4*Nblock) = Th+0i;
Mask(rng+1+Nblock,rng+1) = Th+0i;
Mask(rng+1+Nblock,rng+1+4*Nblock) = Th+0i;
Mask(rng+1+4*Nblock,rng+1+6*Nblock) = Th+0i;
Mask(rng+1+4*Nblock,rng+1+2*Nblock) = Tc+0i;
Mask(rng+1+5*Nblock,rng+1+2*Nblock) = Tc+0i;
Mask(rng+1+6*Nblock,rng+1+2*Nblock) = Tc+0i;

dT = 2*threshold;
T = relaxStep(T,Mask);

while dT > threshold
    Tnew = relaxStep(T,Mask);
    dT = max(max(abs(Tnew-T)));
    imagesc(Tnew);
    T = Tnew;
    imagesc(T);
    pause(0.0001)
end
end

function Tnew = relaxStep(T,Mask)
N = size(T,1);
M = size(T,2);
Tnew = T;
for n = 1:N
    for m = 1:M
        type = imag(Mask(n,m));
        value = real(Mask(n,m));
        if type == -1
            Tnew(n,m) = (T(n,m-1)+T(n,m+1)+T(n+1,m)+T(n-1,m))/4;
        elseif type == 0
            Tnew(n,m) = value;
        elseif type == 1
                Tnew(n,m) = T(n,m+value);
        elseif type == 2
                Tnew(n,m) = T(n+value,m);
        end
    end
end
end