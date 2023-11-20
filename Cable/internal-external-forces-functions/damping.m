function C = damping(depsP, depsM, cable)

% Internal damping forces 
for k = 1:length(depsP)
   
    C(:,k) = cable.Cint*cable.A*(depsP(k) + depsM(k)); 

end




end