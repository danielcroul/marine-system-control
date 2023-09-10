function [xout, xd] = bluerov_init(t)
% [xout, xd] = bluerov_init(t) returns initial values of bluerov state
% parameters with xout = [ u0 v0 w0 p0 q0 r0 x0 y0 z0 phi0 theta0 psi0 ],
%

% Initial conditions
nu10  = [0 0 0];                    % Linear velocity initial conditions        [ u0 v0 w0 ]
nu20  = [0 0 0];                    % Angular velocity initial conditions       [ p0 q0 r0 ]
eta10 = [0 0 20];                   % Position initial conditions               [ x0 y0 z0 ]
eta20 = [0 0 0];                    % Orientation initial conditions            [ phi0 theta0 psi0 ]
init = [nu10 nu20 eta10 eta20]; 

% Desired paths 
xposd = 4*sin(2*pi*0.125*t - pi/2); 
yposd = 4*cos(2*pi*0.125*t - pi/2); 
zposd = 4*ones(1,length(t)); 
phid = 0*ones(1,length(t)); 
thetad = 0*ones(1,length(t)); 
psid = 0*ones(1,length(t)); 

% Initialise 
xout = init; 
xd = [xposd; yposd; zposd; phid; thetad; psid]; 

end