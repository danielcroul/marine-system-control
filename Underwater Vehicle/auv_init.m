function [xinit, ninit] = auv_init(t)
% [xinit, ninit] = auv_init(t) returns initial values of auv state 
% parameters with xinit = [ u0 v0 w0 p0 q0 r0 x0 y0 z0 phi0 theta0 psi0 ],
%
% Initial conditions for x = [ u v w p q r x y z phi theta psi ]'
%
nu  = [0 0 0 0 0 0];                % Linear velocity initial conditions        [ u0 v0 w0 p0 q0 r0 ]
eta = [0 0 0 0 0 0];                % Position initial conditions               [ x0 y0 z0 phi0 theta0 psi0 ]
xinit = [nu, eta]';                 % Combined                                  [ u0 v0 w0 p0 q0 r0 x0 y0 z0 phi0 theta0 psi0 ]'
%
% Propeller revolutions (rps)
%
ninit = [5 5 0 0]';               % ninit = [ n_left n_right n_left_top n_right_top ]'
%
end