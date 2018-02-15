function [x,y] = graphproj( theta, T,dt )
%This is to graph projectile motion
%   Detailed explanation goes here
t=0:dt:T;

x=30*cosd(theta)*t;
y=10+30*sind(theta)*t-(1/2)*9.8*t.^2;
plot(x,y);

end

