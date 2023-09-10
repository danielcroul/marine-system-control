function xdot = wamv_dynamics(t,x,ui,wamv)
% xdot = wamv_dynamics(t,x,ui,wamv) returns the time derivative of the 
% state vector: x = [ u v r x y psi ]' for an Autonomous Surface Vehicle (ASV) 
% platform at James Cook University (JCU).  
%
% The state vector is defined as:
%
% u     = surge velocity          (m/s)
% v     = sway velocity           (m/s)
% r     = yaw velocity            (rad/s)
% x     = position in x-direction (m)
% y     = position in y-direction (m)
% psi   = yaw angle               (rad)
%
% The input vector is :
%
% TO DO ...
% 
% Check input and state dimensions
if (length(x) ~= 6),error('x-vector must have dimension 6!');end
if (length(ui) ~= 4),error('u-vector must have dimension 4!');end
%  
% Extract state vector elements
%
nu  = x(1:3);      % [ u v r ]      (1x3)
eta = x(4:6);      % [ x y psi ]    (1x3)
u = nu(1); 
v = nu(2); 
r = nu(3); 
x = eta(1); 
y = eta(2); 
psi = eta(3); 
%
% MASS MATRIX  
%
Mrb = [wamv.m 0 0; 0 wamv.m wamv.m*wamv.xG; 0 wamv.m*wamv.xG wamv.Iz]; 
Ma  = -[wamv.Xudot 0 0; 0 wamv.Yvdot wamv.Yrdot; 0 wamv.Yrdot wamv.Nrdot];
M   = Mrb + Ma;
%
% CORIOLIS MATRIX
%
Crb = [0 0 -wamv.m*(wamv.xG*r + v); 0 0 wamv.m*u; wamv.m*(wamv.xG*r + v) -wamv.m*u 0]; 
Ca  = [0 0 wamv.Yvdot*v+wamv.Yrdot*r; 0 0 -wamv.Xudot*u; -wamv.Yvdot*v-wamv.Yrdot*r wamv.Xudot*u 0]; 
C   = Crb + Ca; 
%
% DRAG MATRIX
%
Dl = -[wamv.Xu 0 0; 0 wamv.Yv wamv.Yr; 0 wamv.Nv wamv.Nr]; 
Dn = -[wamv.Xuu*abs(u) 0 0; 0 wamv.Yvv*abs(v)+wamv.Yrv*abs(r) wamv.Yvr*abs(v)+wamv.Yrr*abs(r); ...
        0 wamv.Nvv*abs(v)+wamv.Nrv*abs(r) wamv.Nvr*abs(v)+wamv.Nrr*abs(r)]; 
D = Dl + Dn; 
% 
% Dimensional state derivative
%
nudot = pinv(M)*(tau - C*nu' - D*nu');                      % [ udot vdot rdot ]
J = [cos(psi) -sin(psi) 0; sin(psi) cos(psi) 0; 0 0 1]; 
etadot = J*nu';                                             % [ xdot ydot psidot ]

xdot = [nudot; 
        etadot]; 


end