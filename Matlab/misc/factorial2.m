function f = factorial2(n)

if n==1
    f = 1;
else
    f=n*factorial2(n-1);
end
end