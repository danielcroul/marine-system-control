function qhat = tangent_direction(node_positions)

for k = 1:size(node_positions,2)-2

    % Calculate tangent vector between [i-1]-[i]-[i+1]
    nodeT = node_positions(:,k+2) - node_positions(:,k);

    % Unit vector describing tangent direction
    qhat(:,k) = nodeT/norm(nodeT); 
   

end


end