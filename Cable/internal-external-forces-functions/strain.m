function [epsP, epsM] = strain(node_positions, cable)


for k = 1:size(node_positions,2)-2
    
    % Calculate positions of node[i] to adjacent nodes [i-1][i][i+1]
    nodeP = node_positions(:,k+2) - node_positions(:,k+1);
    nodeM = node_positions(:,k) - node_positions(:,k+1); 
    % Note: Below can also be used, provided a sign change is made in
    % 'tension' function. 
    % nodeP = node_positions(:,k+2) - node_positions(:,k+1); 
    % nodeM = node_positions(:,k+1) - node_positions(:,k); 

    % Strain from node i -> i+1
    if norm(nodeP) > cable.Lca
           epsP(:,k) = (1/cable.Lca - 1/norm(nodeP))*nodeP; 
    else
           epsP(:,k) = 0*nodeP; 
    end

    % Strain from node i-1 -> i
    if norm(nodeM) > cable.Lca 
        epsM(:,k) = (1/cable.Lca - 1/norm(nodeM))*nodeM; 
    else
        epsM(:,k) = 0*nodeM; 
    end

end
end