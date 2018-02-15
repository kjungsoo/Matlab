function [ ] = SendPSK( msgPSK )
fb = 2; %baud hz
fs = 100; %sample hz
fc = 10; %carrier hz

Tb = 1/fb; %time domain period
dt = 1/fs; %time interval for sampling
Nb = Tb/dt; %num of samples

msglen = length(msgPSK);
TiPSK = -msglen * Tb : dt : msglen * Tb - dt; %time domain possibly fix
Tlength = length(TiPSK);

SnPSK = zeros(1, Tlength); %symbols, the msg
Pt = NaN(1, Tlength);

for t = 1 : Tlength
    Pt(t) = sinc((2 * TiPSK(t))/Tb) * exp(1i * 2 * pi * fc * TiPSK(t)); %filter
end

waitTime = 3 * Nb;
for sym = 1 : msglen;
    if msgPSK(sym) == 0
        SnPSK(waitTime + (sym - 1) * Nb) = exp(1i * (-3 * pi)/4);
        
    elseif msgPSK(sym) == 1
        SnPSK(waitTime + (sym - 1) * Nb) = exp(1i * ( -pi )/4);
        
    elseif msgPSK(sym) == 2
        SnPSK(waitTime + (sym - 1) * Nb) = exp(1i * ( pi )/4);
        
    elseif msgPSK(sym) == 3
        SnPSK(waitTime + (sym - 1) * Nb) = exp(1i * (3 * pi)/4);
    end
end

TxPSK = conv(SnPSK, Pt, 'same');

figure( 1 )
plot(SnPSK, 'o');

figure( 2 )
plot3(TiPSK, real(TxPSK), imag(TxPSK));

save('PSKsignal', 'TxPSK');
end

