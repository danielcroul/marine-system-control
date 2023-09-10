function [xout, xd] = wamv_init(t)
% [xout, xd] = wamv_init(t) returns initial values of wamv state
% parameters with xout = [ u0 v0 r0 x0 y0 psi0 ]
%

% Initial conditions
nu0 = [0 0 0];              % Linear and angular vel. initial conditions  [ u0 v0 r0 ]
eta0 = [0 0 0];             % Position and orientation initial conditions [ x0 y0 psi0 ]
init = [nu0 eta0]; 

% Desired paths 
xposd = 4*sin(2*pi*0.125*t - pi/2); 
yposd = 4*cos(2*pi*0.125*t - pi/2); 
psid = 0*ones(1,length(t)); 

% Initialise 
xout = init'; 
xd = [xposd; yposd; psid]; 

end