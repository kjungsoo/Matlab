function relax0(N,threshold)
Th = 1;
Tc = 0;
T = zeros(N+2,N+2)+0.5*(Th+Tc); % +2 gives the extra boundary cells; zeros - all the stuff in the middle
% and added the mean for setting every square to the new mean temp.
%T(:,1) = Tc; %semicolon takes entire row (all possible n's here) and sets this cell to one
%T(1,:) = Th;
%T(N+2,:) = Tc;

mid = (N+2)/2;

T(1:mid,1) = Tc;
T((mid+1):end,1) = Th;
T(1:mid, N+2) = Tc;
T((mid+1):end,N+2) = Th;

T(1,:) = Tc;
T(N+2, :) = Th;

T(mid:(mid+1),mid:(mid+1))= 10;

figure(1)
imagesc(T);
pause(5)
dT = 2*threshold;

while dT > threshold
    Tnew = relaxStep(T);
    dT = max(max(abs(Tnew - T))); % difference/ finding the max of it "abs"
%max: takes max of each column and gives you a row of each of these new
%values
    imagesc(Tnew);
    T = Tnew;
    pause(0.1)
end

end 

function Tnew = relaxStep(T)
N = size(T,1);
M = size(T,2);
Tnew = T;
for n = 2:N-1 % "n vs. m"
    for m = 2:M-1
        Tnew(n,m) = (T(n,m-1)+T(n,m+1)+T(n+1,m)+T(n-1,m))/4; %left, right, top, bottom
    end
end
end