function [h, recObj,soundInitial,soundScrambled] = voiceScramble(T)
fs = 8000;
nBits = 16;
nChan = 1;
devID = 0;

% Record for t seconds.
recObj = audiorecorder(fs,nBits,nChan,devID);
disp('Start speaking.')
recordblocking(recObj, T);
disp('End of Recording.');


h = getaudiodata(recObj);
N = 2*floor(length(h)/2);
h = h(1:N);
dt = 1/fs;
T = dt*N;
df = 1/T;
t = (0:N-1)*dt;
f = (0:N-1)*df;

[hscram,H,Hc] = encode(h);

% Plot the waveform.
figure(1)
plot(t,h);
figure(2)
plot(t,hscram);
figure(3)
plot(f,abs(H))
figure(4)
plot(f,abs(Hc))

soundInitial = audioplayer(h,fs);
pause(0.1);

play(soundInitial);

soundScrambled = audioplayer(hscram,fs);
pause(1);
play(soundScrambled);
pause(1);

end

function [hc,H,Hc] = encode(h)
N = length(h);
H = fft(h);
Hc = [H(N/2+1:N);H(1:N/2)];
hc = ifft(Hc);
end
