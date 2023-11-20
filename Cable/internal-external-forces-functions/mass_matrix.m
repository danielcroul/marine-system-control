function M = mass_matrix(qhat, const, cable)


% Mass Matrix
for k = 1:length(qhat)

    Mc(:,:,k) = pi/4*(cable.d)^2*cable.Lca*cable.rho*eye(3); 
    Ma(:,:,k) = pi/4*(cable.d)^2*cable.Lca*const.rho*(cable.Can*(eye(3) - qhat(:,k)*qhat(:,k)') + cable.Cat*(qhat(:,k)*qhat(:,k)')); 
    M(:,:,k) = Mc(:,:,k) + Ma(:,:,k); 
    % M(:,:,k) = max(M(:,:,k), 0); % set any elements less than zero to zero
    
end




end
