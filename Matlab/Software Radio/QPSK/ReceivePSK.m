function [ ] = ReceivePSK( TxPSK ) %msg
%signal = Send( msg ); %testing purposes, will use diff signal
fb = 2; %baud hz
fs = 100; %sample hz
fc = 10; %carrier hz

Tb = 1/fb; %time domain period
dt = 1/fs; %time interval for sampling
Nb = Tb/dt; %num of samples

Txlength = length(TxPSK);
Td = -Txlength/(2 * fs) : dt : Txlength/(2 * fs) - dt;
Tlength = length(Td);
Pt = NaN(1, Tlength);

for t = 1 : Tlength
    Pt(t) = sinc((2 * Td(t))/Tb) * exp(1i * 2 * pi * fc * Td(t)); %filter
end

RxPSK = conv(TxPSK, Pt, 'same');

NMax = Txlength/Nb - 2;
Pulsemax = NaN(1, NMax);
Decodedmsg = NaN(1, NMax);
Decodedmsgbin = NaN(1, NMax);
trim = 0;
for sym = 1 : NMax
    if RxPSK(3 * Nb + (sym - 1) * Nb) > -3 && RxPSK(3 * Nb + (sym - 1) * Nb) < 3
        Pulsemax(sym) = NaN;
        
    else
        Pulsemax(sym) = RxPSK(3 * Nb + (sym - 1) * Nb);
        Decodedmsg(sym) = round((2/pi) * imag(log(Pulsemax(sym))) + 3/2);
        trim = trim + 1;
    end
    
    if Decodedmsg(sym) == 0
        Decodedmsgbin(sym) = 0;
        
    elseif Decodedmsg(sym) == 1
        Decodedmsgbin(sym) = 2;
        
    elseif Decodedmsg(sym) == 2
        Decodedmsgbin(sym) = 3;
        
    elseif Decodedmsg(sym) == 3
        Decodedmsgbin(sym) = 1;
    end
end

TrimmedDecode = Decodedmsg(1 : trim);
TrimmedDecodebin = Decodedmsgbin(1 : trim);

%disp(TrimmedDecodebin);
disp(TrimmedDecode);

figure(3)
plot3(Td, real(RxPSK), imag(RxPSK));

figure(4)
plot(Pulsemax, 'o');

save('decodedMsg', 'TrimmedDecode')
end