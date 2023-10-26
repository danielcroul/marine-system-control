function yout = euler(F,t0,h,tfinal,y0,uin, asv)
% EULER  Classical Euler method ODE solver.
%   yout = EULER(F,t0,h,tfinal,y0) uses the classical
%   Euler method with fixed step size h on the interval
%      t0 <= t <= tfinal
%   to solve
%      dy/dt = F(t,y)
%   with y(t0) = y0.

%   Copyright 2014 - 2015 The MathWorks, Inc.

  y = y0;
  yout = y;
  u = uin;

  for t = t0 : h : tfinal-h   
     
     % Euler integration (k+1)
     y = y + h * F(t,y,u,asv);
     yout = [yout y]; %ok
  end

end