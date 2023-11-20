function xdot = cable_dynamics(t,x,ui,const,cable)
% xdot[i] = cable_dynamics(t,x,ui, cable) returns the time derivative of the
% state vector: x[i] = [ xdot[i] ydot[i] zdot[i] x[i] y[i] z[i] ]' for an umbilical cable.
%
% The state vector is defined as:
%
% xdot[i]    = node velocity in x (earth frame)         (m/s)
% ydot[i]    = node velocity in y (earth frame)         (m/s)
% zdot[i]    = node velocity in z (earth frame)         (m/s)
% x[i]       = node position in x (earth frame)         (m)
% y[i]       = node position in y (earth frame)         (m)
% z[i]       = node position in z (earth frame)         (m)
%
% The input vector is :
%
% ui = [ xdot_asv ydot_asv zdot_asv x_asv y_asv z_asv  xdot_auv ydot_auv zdot_auv x_auv y_auv z_auv  ]'
%
% xdot_asv  = velocity of asv in x (earth frame)
% ydot_asv  = velocity of asv in y (earth frame)
% zdot_asv  = velocity of asv in z (earth frame)
% x_asv     = position of asv in x (earth frame)
% y_asv     = position of asv in y (earth frame)
% z_asv     = position of asv in z (earth frame)
%
% xdot_auv  = velocity of auv in x (earth frame)
% ydot_auv  = velocity of auv in y (earth frame)
% zdot_auv  = velocity of auv in z (earth frame)
% x_auv     = position of auv in x (earth frame)
% y_auv     = position of auv in y (earth frame)
% z_auv     = position of auv in z (earth frame)
%
% Setup velocity-position matrices 
%
vel_asv_xyz = ui(1:3);
pos_asv_xyz = ui(4:6);
vel_auv_xyz = ui(7:9); 
pos_auv_xyz = ui(10:12); 
node_positions = [pos_asv_xyz, x(4:6,:), pos_auv_xyz]; 
node_velocities = [vel_asv_xyz, x(1:3,:), vel_auv_xyz]; 
%
% Calculate parameters
%
[epsP, epsM] = strain(node_positions, cable); 
[depsP, depsM] = strain_rate(node_positions, node_velocities, cable); 
qhat = tangent_direction(node_positions); 
%
% Calculate internal-external forces, mass matrix
%
T = tension(epsP, epsM, cable); 
C = damping(depsP, depsM, cable); 
D = drag(qhat,node_velocities, const, cable); 
M = mass_matrix(qhat,const,cable); 
%
% State derivative (loop through nodes)
%
for k = 1:length(M)

    xdot(:,k) = [pinv(M(:,:,k)), zeros(3); zeros(3), zeros(3)]*[T(:,k) + C(:,k) + D(:,k); zeros(3,1)] + [zeros(3), zeros(3); eye(3), zeros(3)]*x(:,k) ;
                  
    % halt execution if NaNs are found
    if isnan(xdot(:,k))
        xdot
        disp(t); 
        error('NaNs encountered'); 
    end

end


end