function quiz2(threshold)
Th = 1;
Tc = 0;
right = +1+1i;
left = -1+1i;
up = -1+2i;
down = +1+2i;

Nx = 5+2;
Ny = 7+2;

Mask(:,1) = right;
Mask(:,Ny) = left;
Mask(1,:) = down;
Mask(Nx,:) = up;

T = zeros(Ny,Nx) + (Th+Tc)/2;
Mask = zeros(Ny,Nx) + (0-1i);

%rng = 1:Nblock;
Mask(2,2) = Th+0i;
Mask(2,6) = Th+0i;
Mask(3,1) = Th+0i;
Mask(3,6) = Th+0i;
Mask(6,4) = Tc+0i;
%Mask(rng+1+4*Nblock,rng+1+2*Nblock) = Tc+0i;
%Mask(rng+1+4*Nblock,rng+1+6*Nblock) = Th+0i;

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
N = size(T,1)
M = size(T,2)
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