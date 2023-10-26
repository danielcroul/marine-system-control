function xdot = asv_dynamics(t,x,ui,asv)
% xdot = asv_dynamics(t,x,ui,asv) returns the time derivative of the 
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
% ui = [ ui(1) ui(2) ]' where
%   ui(1): propeller shaft speed, left (rad/s)
%   ui(2): propeller shaft speed, right (rad/s)
% 
% Check input and state dimensions
if (length(x) ~= 6),error('x-vector must have dimension 6!');end
if (length(ui) ~= 2),error('u-vector must have dimension 2!');end
%  
% Extract state vector elements
%
nu  = x(1:3);      % [ u v r ]'      (3x1)
eta = x(4:6);      % [ x y psi ]'    (3x1)
u = nu(1); 
v = nu(2); 
r = nu(3); 
psi = eta(3); 
%
% MASS MATRIX  
%
Mrb = [asv.m 0 0; 0 asv.m asv.m*asv.xG; 0 asv.m*asv.xG asv.Iz]; 
Ma  = -[asv.Xudot 0 0; 0 asv.Yvdot asv.Yrdot; 0 asv.Yrdot asv.Nrdot];
M   = Mrb + Ma;
%
% CORIOLIS MATRIX
%
Crb = [0 0 -asv.m*(asv.xG*r + v); 0 0 asv.m*u; asv.m*(asv.xG*r + v) -asv.m*u 0]; 
Ca  = [0 0 asv.Yvdot*v+asv.Yrdot*r; 0 0 -asv.Xudot*u; -asv.Yvdot*v-asv.Yrdot*r asv.Xudot*u 0]; 
C   = Crb + Ca; 
%
% DRAG MATRIX
%
Dl = -[asv.Xu 0 0; 0 asv.Yv asv.Yr; 0 asv.Nv asv.Nr]; 
% Dn = -[asv.Xuu*abs(u) 0 0; 0 asv.Yvv*abs(v)+asv.Yrv*abs(r) asv.Yvr*abs(v)+asv.Yrr*abs(r); ...
%         0 asv.Nvv*abs(v)+asv.Nrv*abs(r) asv.Nvr*abs(v)+asv.Nrr*abs(r)]; 
% D = Dl + Dn; 
D = Dl; 
% 
% Control forces and moments
%
thrust = zeros(2,1); 
for i = 1:1:2
    if ui(i) > asv.n_max
        ui(i) = asv.n_max; 
    elseif ui(i) < asv.n_min
        ui(i) = asv.n_min; 
    end

    if ui(i) < 0
        thrust(i) = asv.k_pos * ui(i) * abs(ui(i)); % positive thrust (N)
    else
        thrust(i) = asv.k_neg * ui(i) * abs(ui(i)); % negative thrust (N)
    end
end

tau = [thrust(1) + thrust(2), 0, -asv.l1 * thrust(1) - asv.l2 * thrust(2)]'; 
%
% Dimensional state derivative
%
nudot = pinv(M)*(tau - C*nu - D*nu);                      % [ udot vdot rdot ]'
J = [cos(psi) -sin(psi) 0; sin(psi) cos(psi) 0; 0 0 1]; 
etadot = J*nu;                                             % [ xdot ydot psidot ]'

xdot = [nudot; 
        etadot]; 


end