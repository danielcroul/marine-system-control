function plotOrientation(centre, angle_rad)
% Plot unit vectors (x, y, z) rotated about all three axes

% Extract rotation angles
phi = angle_rad(1);
theta = angle_rad(2);
psi = angle_rad(3);

% Define unit vectors along the x, y, and z axes
unit_x = [1, 0, 0];
unit_y = [0, 1, 0];
unit_z = [0, 0, 1];

% Rotation matrix
R = Rzyx(phi,theta,psi); 

% Rotate unit vectors
rotated_unit_x = R * unit_x';
rotated_unit_y = R* unit_y';
rotated_unit_z = R * unit_z';

% Plot the rotated unit vectors
% figure;
% hold on;
quiver3(centre(1), centre(2), centre(3), rotated_unit_x(1), rotated_unit_x(2), rotated_unit_x(3), 'r', 'LineWidth', 2, 'MaxHeadSize', 0.2);
quiver3(centre(1), centre(2), centre(3), rotated_unit_y(1), rotated_unit_y(2), rotated_unit_y(3), 'g', 'LineWidth', 2, 'MaxHeadSize', 0.2);
quiver3(centre(1), centre(2), centre(3), rotated_unit_z(1), rotated_unit_z(2), rotated_unit_z(3), 'b', 'LineWidth', 2, 'MaxHeadSize', 0.2);
% xlabel('X-axis');
% ylabel('Y-axis');
% zlabel('Z-axis');
% title('Rotated Unit Vectors');
% axis equal;
% grid on;
% view(3);
% hold off;

end