function [rn,vn,tn] = rkStep(r,v,t,dt,par,order)
if order == 1
    rn = r + v*dt;
    vn = v + acceleration(r,v,t,par)*dt;
elseif order == 2
    rmid = r + v*dt/2;
    vmid = v + acceleration(r,v,t,par)*dt/2;
    tmid = t + dt/2;
    rn = r + vmid*dt;
    vn = v + acceleration(rmid,vmid,tmid,par)*dt;
elseif order == 4
    dra = v*dt;
    dva = acceleration(r,v,t,par)*dt;
    drb = (v+dva/2)*dt;
    dvb = acceleration(r+dra/2,v+dva/2,t+dt/2,par)*dt;
    drc = (v+dvb/2)*dt;
    dvc = acceleration(r+drb/2,v+dvb/2,t+dt/2,par)*dt;
    drd = (v+dvc)*dt;
    dvd = acceleration(r+drc,v+dvc,t+dt,par)*dt;
    rn = r + dra/6 + drb/3 + drc/3 + drd/6;
    vn = v + dva/6 + dvb/3 + dvc/3 + dvd/6;
else
    error('That order is not implemented, choose 1,2,or 4.')
end
tn = t + dt;
end

function a = acceleration(r,v,t,par,beta,omega)
a =-sin(r) - beta*v + par*sin(omega*t);
end