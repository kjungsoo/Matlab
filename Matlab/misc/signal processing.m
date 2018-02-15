% signal processing
% H = a0/N + (2/N)*sum aN*cos(2*pi*df*t+phase)
% N = sample
% t = (0:N-1)*dt;
% fs = 1/dt; sample rate
% dt = 1/fs
% T = N * dt
% df = 1/T; frequency
% aN, a0 = amplitudes

%windowing
%fn = n*df
%  ex: f(N/2) = (N/2)*df