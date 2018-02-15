function relax()
N = 10;
T = zeros(N+2,N+2);
Tnew = NaN(N+2,N+2);
T(:,1) = 1;
T(1:1,N+2) = .5;
T(1:5,N+2) = 0;
T(5:N+2,N+2) = .5;
T(1,:) = .5;
T(N+2,1:2) = .5;
T(N+2,2:4) = 1;
T(N+2,4:N+2) = .5;


figure(2)
imagesc(T);
end