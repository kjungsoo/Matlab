function response(v0,y0,T)
w = 5:0.1:7;
A = NaN(1,length(w));

n=1; 
while n < length(w)
    A(n) = testdamping(v0,y0,w(n),T);
    n = n+1; 
end
figure(2)
plot(w,A)
end