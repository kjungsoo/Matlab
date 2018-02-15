function gauss(a, xpos, L, p0)

potential_well = zeros(1,L);
%axis = [-100:100]; %some axis
hbar = 1.0545718 * 10^(-34);
%gauss = NaN(1,length(x_axis)); %currently an array
gaussExpression = NaN(1,length(potential_well));

x_pos = xpos; %position so that gaussian is well localized
gauss_width = a; %constant so that gauss is well defined
norm = sqrt(sqrt(pi)*gauss_width); %to normalize the gaussian

% for index = 1:length(x_axis)
%     gauss(index) = exp(-1*(index - x_pos)^2/(2*a))/norm;
for index = 1:length(potential_well)
    gaussExpression(index) = exp(-1*(index - x_pos)^2/(2*gauss_width))/norm; %+1i*p0*index
end
figure(1)
plot(abs(gaussExpression).^2)

figure(2)
plot(gaussExpression)
end