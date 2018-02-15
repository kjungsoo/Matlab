function [] = Receive16QAM( Tx16QAM )
fb = 2; %baud hz
fs = 100; %sample hz
fc = 10; %carrier hz

Tb = 1/fb; %time domain period
dt = 1/fs; %time interval for sampling
Nb = Tb/dt; %num of samples

Txlength = length(Tx16QAM);
Td = -Txlength/(2 * fs) : dt : Txlength/(2 * fs) - dt;
Tlength = length(Td);
Pt = NaN(1, Tlength);

for t = 1 : Tlength
    Pt(t) = sinc((2 * Td(t))/Tb) * exp(1i * 2 * pi * fc * Td(t)); %filter
end

Rx16QAM = conv(Tx16QAM, Pt, 'same');

NMax = Txlength/Nb - 2;
Pulsemax = NaN(1, NMax);
trim = 0;

for sym = 1 : NMax
    if Rx16QAM(3 * Nb + (sym - 1) * Nb) > -5 && Rx16QAM(3 * Nb + (sym - 1) * Nb) < 5
        Pulsemax(sym) = NaN;
        
    else
        Pulsemax(sym) = Rx16QAM(3 * Nb + (sym - 1) * Nb);
        trim = trim + 1;
    end
end

Trimmedpulse = Pulsemax(1 : trim);
RxReal = real(Trimmedpulse)/(mean(abs(real(Trimmedpulse)))) + 3/2;
RxImag = imag(Trimmedpulse)/(mean(abs(imag(Trimmedpulse)))) + 3/2;
Rx16QAM = 2*RxReal - 3 + 1i * (2*RxImag - 3);

decodelen = length(Rx16QAM);
decode = NaN(1, decodelen);

for n = 1 : decodelen
    decode(n) = round(real(Rx16QAM(n))/2 + 3/2);
    if round(imag(Rx16QAM(n))) == -1
        decode(n) = decode(n) + 4;
    elseif round(imag(Rx16QAM(n))) == 1
        decode(n) = decode(n) + 8;
    elseif round(imag(Rx16QAM(n))) == 3
        decode(n) = decode(n) + 12;
    end
end

disp(round(Rx16QAM))
disp(decode)

figure(5)
plot(Rx16QAM, 'o');
end