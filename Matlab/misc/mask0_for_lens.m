function c = mask0_for_lens()
index = 1.5;
c = ones(50,50);
for n = 1:50
    for m = 1:50
        c1 = m >= 10;
        c2 = n > m;
        c3 = m < 50 - n;
        if c1 && c2 && c3
            c(n,m) = 1/index;
        end
    end
end
imagesc(c)
end