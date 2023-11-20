function D = drag(qhat,node_velocities, const, cable)


% Damping
for k = 1:length(qhat)
   vdelta(:,k) = -node_velocities(:,k+1); 
   vt(:,k) = dot(vdelta(:,k), qhat(:,k))*qhat(:,k); 
   vn(:,k) = vdelta(:,k) - vt(:,k); 

   
   D(:,k) = 1/2*const.rho*cable.Cdn*cable.d*cable.Lca*norm(vn(:,k))*vn(:,k) + pi/2*const.rho*cable.Cdt*cable.d*cable.Lca*norm(vt(:,k))*vt(:,k); 

end




end