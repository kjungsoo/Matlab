function [] = Send16QAM( msg16QAM )
fb = 2; %baud
fs = 100; %sample
fc = 10; %carrier

Tb = 1/fb; %time domain period
dt = 1/fs; %time interval for sampling
Nb = Tb/dt; %num of samples

msglen = length(msg16QAM);
T16QAM = -msglen * Tb : dt : msglen * Tb - dt; %time domain possibly fix
Tlength = length(T16QAM);

Sn16QAM = zeros(1, Tlength); %symbols, the msg
Pt = NaN(1, Tlength);

for t = 1 : Tlength
    Pt(t) = sinc((2 * T16QAM(t))/Tb) * exp(1i * 2 * pi * fc * T16QAM(t)); %filter
end

waitTime = 3 * Nb;

for sym = 1 : msglen
    if intersect(msg16QAM(sym), (0:3)) == msg16QAM(sym);
        Sn16QAM(waitTime + (sym - 1) * Nb) = 2 * (msg16QAM(sym)) - 3 + 1i * -3;
        
    elseif intersect(msg16QAM(sym), (4:7)) == msg16QAM(sym);
        Sn16QAM(waitTime + (sym - 1) * Nb) = 2 * (msg16QAM(sym) - 4) - 3 + 1i * -1;
        
    elseif intersect(msg16QAM(sym), (8:11)) == msg16QAM(sym);
        Sn16QAM(waitTime + (sym - 1) * Nb) = 2 * (msg16QAM(sym) - 8) - 3 + 1i * 1;
        
    elseif intersect(msg16QAM(sym), (12:15)) == msg16QAM(sym);
        Sn16QAM(waitTime + (sym - 1) * Nb) = 2 * (msg16QAM(sym) - 12) - 3 + 1i * 3; 
    end
end

Tx16QAM = conv(Sn16QAM, Pt, 'same');

figure( 1 )
plot(Sn16QAM, 'o');

figure( 2 )
plot3(T16QAM, real(Tx16QAM), imag(Tx16QAM));

save('16QAMsignal', 'Tx16QAM');
end