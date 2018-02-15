function [ ] = txtToPSKmsg(txt)
sym = [0, 1, 2, 3];
PSKmsg = NaN(1,4*length(txt));
for n = 1:length(txt)
    for x1 = 1:4
        for x2 = 1:4
            for x3 = 1:4
                for x4 = 1:4
                    if sym(x1) + 4*sym(x2) + 16*sym(x3) + 64*sym(x4) == double(txt(n))
                        symindex = [sym(x1), sym(x2), sym(x3), sym(x4)];
                    end
                end
            end
        end
    end
    offset = (n-1)*4;
    PSKmsg(offset + (1:4)) = symindex;
end
disp(PSKmsg);

save('PSKmsg', 'PSKmsg');
end