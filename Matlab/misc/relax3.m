function relax3(threshold,Nblock)
N = 9*Nblock+2;
Th = 1;
Tc = 0;
right = +1+1i;
left = -1+1i;
up = -1+2i;
down = +1+2i;

T = zeros(N,N) + (Th+Tc)/2; %everything set to average temperature
Mask = zeros(N,N) + (0-1i); %everything set to normal (-1)

Mask(:,1) = right;
Mask(:,N) = left;
Mask(1,:) = down;
Mask(N,:) = up;

rng = 1:Nblock;
Mask(rng+1+4*Nblock,rng+1+2*Nblock) = Tc+0i;
Mask(rng+1+4*Nblock,rng+1+6*Nblock) = Th+0i;

figure(1)
imagesc(T);
% pause(1)
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
            %if value == 1
                Tnew(n,m) = T(n,m+value);
            %elseif value == -1
            %    Tnew(n,m) = T(n-value,m);
            %end
        elseif type == 2
            %if value == 1
                Tnew(n,m) = T(n+value,m);
            %elseif value == -1
            %    Tnew(n,m) = T(n-value,m);
            %end
        end
    end
end
end