function yout = ode4(F,t0,h,tfinal,y0,uin, sys)
% ODE4  Classical Runge-Kutta ODE solver.
%   yout = ODE4(F,t0,h,tfinal,y0) uses the classical
%   Runge-Kutta method with fixed step size h on the interval
%      t0 <= t <= tfinal
%   to solve
%      dy/dt = F(t,y)
%   with y(t0) = y0.

%   Copyright 2014 - 2015 The MathWorks, Inc.

  y = y0;
  yout = y;
  k=1;
  u = uin;
  for t = t0 : h : tfinal-h   
     
     s1 = F(t,y,u,sys);
     s2 = F(t+h/2, y+h*s1/2,u,sys);
     s3 = F(t+h/2, y+h*s2/2,u,sys);
     s4 = F(t+h, y+h*s3,u,sys);
     y = y + h*(s1 + 2*s2 + 2*s3 + s4)/6;
     yout = [yout y]; %ok
     k=k+1;
  end
end