function xdot = auv_dynamics(t,x,ui,auv)
% xdot = auv_dynamics(t,x,ui,brov) returns the time derivative of the 
% state vector: x = [ u v w p q r x y z phi theta psi ]' for
% an Autonomous Underwater Vehicle (AUV) platform. 
%
% The state vector is defined as:
%
% u     = surge velocity          (m/s)
% v     = sway velocity           (m/s)
% w     = heave velocity          (m/s)
% p     = roll velocity           (rad/s)
% q     = pitch velocity          (rad/s)
% r     = yaw velocity            (rad/s)
% x     = position in x-direction (m)
% y     = position in y-direction (m)
% z     = position in z-direction (m)
% phi   = roll angle              (rad)
% theta = pitch angle             (rad)
% psi   = yaw angle               (rad)
%
% The input vector is :
%
% ui = [ ui(1) ui(2) ui(3) ui(4)]' where
%   ui(1): propeller shaft speed, left      (rad/s)
%   ui(2): propeller shaft speed, right     (rad/s)
%   ui(3): propeller shaft speed, left top  (rad/s)
%   ui(4): propeller shaft speed, right top (rad/s)
% 
% Check input and state dimensions
if (length(x) ~= 12),error('x-vector must have dimension 12!');end
if (length(ui) ~= 4),error('u-vector must have dimension 4!');end
%  
% Extract state vector elements
%
nu1  = x(1:3);      % [ u v w ]'                 (3x1)
nu2  = x(4:6);      % [ p q r ]'                 (3x1)
eta2 = x(10:12);    % [ phi theta psi ]'         (3x1)
u = nu1(1); 
v = nu1(2); 
w = nu1(3); 
p = nu2(1); 
q = nu2(2); 
r = nu2(3); 
phi = eta2(1); 
theta = eta2(2); 
psi = eta2(3); 
if (theta == -pi), error('Singularity encountered with -theta.'); end
if (theta == pi), error('Singularity encountered with +theta.'); end
%
% MASS MATRIX  
%
Mrb = [auv.m*eye(3) zeros(3); zeros(3) auv.I]; 
Ma  = -diag([auv.Xudot auv.Yvdot auv.Zwdot auv.Kpdot auv.Mqdot auv.Nrdot]); 
M   = Mrb + Ma; 
%
% CORIOLIS MATRIX
%
Crb = m2c(Mrb, [nu1;nu2]); 
Ca  = m2c(Ma , [nu1;nu2]); 
C   = Crb + Ca; 
%
% DRAG MATRIX
%
Dl = -diag([auv.Xu auv.Yv auv.Zw auv.Kp auv.Mq auv.Nr]); 
Dn = -diag([auv.Xuu*abs(u) auv.Yvv*abs(v) auv.Zww*abs(w) auv.Kpp*abs(p) auv.Mqq*abs(q) auv.Nrr*abs(r)]);
D  = Dl + Dn; 
%
% GRAVITATIONAL AND BUOYANCY VECTOR
%
auv_params; % Load workspace variables
Gn = gvect(auv.W, auv.B, theta, phi, [auv.xG,auv.yG, auv.zG]',[auv.xB, auv.yB, auv.zB]'); 
% 
% Control forces and moments
%
thrust = zeros(4,1); 
for i = 1:1:4
    if ui(i) > auv.n_max
        ui(i) = auv.n_max; 
    elseif ui(i) < auv.n_min
        ui(i) = auv.n_min; 
    end

    if ui(i) < 0
        thrust(i) = auv.k_pos * ui(i) * abs(ui(i)); % positive thrust (N)
    else
        thrust(i) = auv.k_neg * ui(i) * abs(ui(i)); % negative thrust (N)
    end
end

tau = [thrust(1) + thrust(2), 0, thrust(3) + thrust(4), 0, 0, -auv.l1 * thrust(1) - auv.l2 * thrust(2)]'; 
%
% Dimensional state derivative
%
nudot   = pinv(M)*(tau - C*[nu1; nu2] - D*[nu1; nu2] - Gn); % [ udot vdot wdot pdot qdot rdot ]'
J       = eulerang(phi,theta,psi); 
etadot  = J*[nu1; nu2];                                     % [ xdot ydot zdot phidot thetadot psidot ]'

xdot = [nudot; 
        etadot]; 


end