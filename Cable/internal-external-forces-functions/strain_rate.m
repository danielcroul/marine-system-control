function [depsP, depsM] = strain_rate(node_positions, node_velocities, cable)

for k = 1:size(node_positions,2)-2

    % Calculate positions of node[i] to adjacent nodes [i-1][i][i+1]
    % Calculate velocities of node[i] to adjacent nodes [i-1][i][i+1]
    nodeP = node_positions(:,k+2) - node_positions(:,k+1); 
    dnodeP = node_velocities(:,k+2) - node_velocities(:,k+1);
    nodeM = node_positions(:,k) - node_positions(:,k+1);
    dnodeM = node_velocities(:,k) - node_velocities(:,k+1);
    % Note: Below can also be used, provided a sign change is made in the
    % 'damping' function. 
    % nodeM = node_positions(:,k+1) - node_positions(:,k);
    % dnodeM = node_velocities(:,k+1) - node_velocities(:,k);
    

    % Strain rate from node i -> i+1  
    depsP(:,k) = (1/cable.Lca)*(1/norm(nodeP)/norm(nodeP))*(nodeP'*dnodeP)*nodeP; 

    % Strain rate from node i -> i-1  
    depsM(:,k) = (1/cable.Lca)*(1/norm(nodeM)/norm(nodeM))*(nodeM'*dnodeM)*nodeM;

end
end