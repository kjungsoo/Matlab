function threebody(x1, x2, x3, y1, y2, y3, m1, m2, m3, dt, T)
%threebody(0, 0, -1, 1, -1, 0, 2, 2, .002, .01, 100)
t = 0:dt:T;
N = length(t);
V = NaN(3, 2, N);
R = NaN(3, 2, N);

r1 = [x1, y1];
r2 = [x2, y2];
r3 = [x3, y3];
r_vector12 = abs(r1 - r2);
r_vector13 = abs(r1 - r3);
r_vector23 = abs(r2 - r3);

M = [m1,m2,m3];

n = 1;
R(:, :, n) = [r_vector12; r_vector13; r_vector23];
V(:, :, n) = [0.5,0.5;0.5,0.5;0.5,0.5];
while n < N
    %tmid = t(n) +.5 * dt;
    Vmid(:, :) = V(:, :, n) + acc(R(:, :, n), M) * .5 * dt;
    Rmid(:, :) = R(:, :, n) + V(:, :, n) * .5 * dt;
    V(:, :, n+1) = V(:, :, n) + acc(Rmid, M) * dt;
    R(:, :, n+1) = R(:, :, n) + Vmid * dt;

    n = n + 1;
end
Rx1 = NaN(1, N);
Rx2 = NaN(1, N);
Rx3 = NaN(1, N);
Ry1 = NaN(1, N);
Ry2 = NaN(1, N);
Ry3 = NaN(1, N);

for n = 1:N
    Rx1(n) = R(1, 1, n);
    Rx2(n) = R(2, 1, n);
    Rx3(n) = R(3, 1, n);
    Ry1(n) = R(1, 2, n);
    Ry2(n) = R(2, 2, n);
    Ry3(n) = R(3, 2, n);

end

figure(1)
plot(Rx1, Ry1, Rx2, Ry2, Rx3, Ry3)

end

function A = acc(R, M)
    G = -1;
    r12 = R(1,:)-R(2,:); %need vector (+/-) and update r1 - r2 
    
    a1 = ((G * M(2))/(sqrt(R(1, :) * R(1, :)'))^3) * (R(1,:)) + ((G * M(3))/(sqrt(R(2, :) * R(2, :)'))^3) * (R(2, :));
    a2 = ((G * M(1))/(sqrt(R(1, :) * R(1, :)'))^3) * (R(1,:)) + ((G * M(3))/(sqrt(R(3, :) * R(3, :)'))^3) * (R(3, :));
    a3 = ((G * M(1))/(sqrt(R(2, :) * R(2, :)'))^3) * (R(2,:)) + ((G * M(2))/(sqrt(R(3, :) * R(3, :)'))^3) * (R(3, :));
    
    A = [a1; a2; a3];
end 