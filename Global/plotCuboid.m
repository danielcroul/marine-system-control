function plotCuboid(length, height, width, centre, angle_rad)

% Define the half-dimensions
halfLength = length / 2;
halfHeight = height / 2;
halfWidth = width / 2;

% Define the angles
phi = angle_rad(1); 
theta = angle_rad(2); 
psi = angle_rad(3); 

% Define the cuboid's vertices
vertices = [
    -halfLength, -halfHeight, -halfWidth;
     halfLength, -halfHeight, -halfWidth;
     halfLength,  halfHeight, -halfWidth;
    -halfLength,  halfHeight, -halfWidth;
    -halfLength, -halfHeight,  halfWidth;
     halfLength, -halfHeight,  halfWidth;
     halfLength,  halfHeight,  halfWidth;
    -halfLength,  halfHeight,  halfWidth;
];

% Rotate the vertices
vertices = (Rzyx(phi,theta,psi) * vertices')';

% Adjust the vertices to the specified center
vertices = vertices + centre;

% Define the cuboid's faces by specifying the vertex indices
faces = [
    1, 2, 3, 4;  % Bottom face
    5, 6, 7, 8;  % Top face
    1, 2, 6, 5;  % Side face 1
    2, 3, 7, 6;  % Side face 2
    3, 4, 8, 7;  % Side face 3
    4, 1, 5, 8;  % Side face 4
];

% Plot the cuboid
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', 'k', 'EdgeColor', 'k','FaceAlpha',0.2);

end
