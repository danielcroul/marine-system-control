function T = tension(epsP, epsM,  cable)

% Tension
for k = 1:length(epsP)

    T(:,k) = cable.E*cable.A*(epsP(:,k) + epsM(:,k)); 
    
end



end