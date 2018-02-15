function y = iteratecos(x)
%iterating with cos
notDone = 1;
while notDone
    y = cos(x);
    notDone = abs(y-x)>0.0001;
    x=y;
end