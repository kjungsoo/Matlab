function Signal
% Homework Problem 5.5
% 05.06.2015

T  = 0.125;
N  = 128; % we want 128 samples
dt = T/N;
t = (0:N-1)*dt;
df = 1/T;
f  = (0:N-1)*df;
s1 = cos(2*pi*200*t); % 1st desired frequency at 200 Hz
s2 = cos(2*pi*204*t); % 2nd desired frequency at 204 Hz

% with the Hann() function:
w  = hann(N);
H1  = fft(s1.*w'); % need to rotate the w matrix for matrix multiplication
H2 = fft(s2.*w');

figure(1)
plot(f,abs(H1),f,abs(H2));

% without the Hann() function:
H_1 = fft(s1);
H_2 = fft(s2);

figure(2)
plot(f,abs(H_1),f,abs(H_2));

end

