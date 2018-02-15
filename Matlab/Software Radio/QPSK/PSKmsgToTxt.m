function txt = PSKmsgToTxt(PSKmsg)
Ns = length(PSKmsg);
Nchar = floor(Ns/4);
c = NaN(1,Nchar);
 
for n = 1:Nchar
    offset = (n-1)*4;
    c(n) = PSKmsg(offset+(1:4))*[1;4;16;64];
end

txt = char(c);
end