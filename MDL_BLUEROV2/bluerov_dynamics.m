function xdot = bluerov_dynamics(t,x,ui,brov)
% xdot = bluerov_dynamics(t,x,ui,brov) returns the time derivative of the 
% state vector: x = [ u v w p q r x y z phi theta psi ]' for
% an Autonomous Underwater Vehicle (AUV) platform at the Australian Institute of Marine Science (AIMS). 
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
% TO DO ...
% 
% Check input and state dimensions
if (length(x) ~= 12),error('x-vector must have dimension 12!');end
if (length(ui) ~= 6),error('u-vector must have dimension 6!');end
%  
% Extract state vector elements
%
nu1  = x(1:3);      % [ u v w ]                 (1x3)
nu2  = x(4:6);      % [ p q r ]                 (1x3)
eta1 = x(7:9);      % [ x y z ]                 (1x3)
eta2 = x(10:12);    % [ phi theta psi ]         (1x3)
u = nu1(1); 
v = nu1(2); 
w = nu1(3); 
p = nu2(1); 
q = nu2(2); 
r = nu2(3); 
x = eta1(1); 
y = eta1(2); 
z = eta1(3); 
phi = eta2(1); 
theta = eta2(2); 
psi = eta2(3); 
%
% MASS MATRIX  
%
Mrb = [brov.m*eye(3) zeros(3); zeros(3) brov.I]; 
Ma  = -diag([brov.Xudot brov.Yvdot brov.Zwdot brov.Kpdot brov.Mqdot brov.Nrdot]); 
M   = Mrb + Ma; 
%
% CORIOLIS MATRIX
%
Crb = [zeros(3) -brov.m*Smtrx(nu1)-brov.m*Smtrx(nu2)*Smtrx(brov.cog); -brov.m*Smtrx(nu1)+brov.m*Smtrx(brov.cog)*Smtrx(nu2) -Smtrx(brov.I*nu2')]; 
Ca  = [zeros(3) -Smtrx(MA(1:3,1:3)*nu1'+MA(1:3,4:6)*nu2'); -Smtrx(MA(1:3,1:3)*nu1'+MA(1:3,4:6)*nu2') -Smtrx(MA(4:6,1:3)*nu1'+MA(4:6,4:6)*nu2')]; 
C   = Crb + Ca; 
%
% DRAG MATRIX
%
Dl = -diag([brov.Xu brov.Yv brov.Zw brov.Kp brov.Mq brov.Nr]); 
Dn = -diag([brov.Xuu*abs(u) brov.Yvv*abs(v) brov.Zww*abs(w) brov.Kpp*abs(p) brov.Mqq*abs(q) brov.Nrr*abs(r)]);
D  = Dl + Dn; 
%
% GRAVITATIONAL AND BUOYANCY VECTOR
%
Gn = [(brov.W - brov.B)*sin(theta); 
       -(brov.W - brov.B)*cos(theta)*sin(phi); 
       -(brov.W - brov.B)*cos(theta)*cos(phi);
       brov.yB*brov.B*cos(theta)*cos(phi)-brov.zB*brov.B*cos(theta)*sin(phi); 
       -brov.zB*brov.B*sin(theta)-brov.xB*brov.B*cos(theta)*cos(phi);
       brov.xB*brov.B*cos(theta)*sin(phi)+brov.yB*brov.B*sin(theta)]; 
% 
% Dimensional state derivative
%
nudot   = pinv(M)*(tau - C*[nu1 nu2]' - D*[nu1 nu2]' - Gn); % [ udot vdot wdot pdot qdot rdot ]
J       = eulerang(phi,theta,psi); 
etadot  = J*[nu1 nu2]';                                    % [ xdot ydot zdot phidot thetadot psidot ]

xdot = [nudot; 
        etadot]; 


end