function make_mask(dx, dy, del, R, T, index_refrac) %T = thickness; R = radius
f = 1/((index_refrac-1)*(2/R)*(1-((index_refrac-1)*T)/(2*index_refrac*R)));

x = -4*del:dx:(4*del+f);
Nx = length(x);
y = -2*del:dy:2*del;
Ny = length(y);

%r1 = (x-R)^2+y^2;
%r2 = (x+R)^2+y^2;

c = ones(Ny,Nx);
%c(round(N/2):N,:) = 1/index_refrac;


%if sqrt(r1) <= R && sqrt(r2) <= R
   % c(x,y) = 1/index_refrac

for m = 1:Nx
    for n = 1:Ny
        r1 = sqrt((m-R)^2+n^2);
        r2 = sqrt((m+R)^2+n^2);
        if r1 <= R && r2 <= R
            c(n,m) = 1/index_refrac;
        end
    end
end
imagesc(c)

%for n = 2:N-1;
%    for m = 2:M-1
%        if c(n,m) == 1
%        else
%        end
%    end
end