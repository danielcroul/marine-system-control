function cable_plot(t, ui, xout)


figure(1)
hold on;
ax = gca;
set(ax, 'ydir','reverse')
set(ax, 'zdir','reverse')
xlabel('x-axis (m)');
ylabel('y-axis (m)');
zlabel('z-axis (m)');
ax.Clipping = "off";
axis equal;
grid minor;
view(-65.9, 26.325)



% plot cable nodes at equally spaced intervals
for i = round(linspace(1, size(xout,3), 10))
    plot3(ui(4,i), ui(5,i), ui(6,i),'bo','MarkerFaceColor','b');    % asv positions
    plot3(ui(10,i), ui(11,i), ui(12,i),'ro','MarkerFaceColor','r'); % auv positions
    plot3(xout(4,:,i), xout(5,:,i), xout(6,:,i), 'k-o','MarkerFaceColor','k','MarkerSize',3);
end


% % 'dynamic' visualisation
% for i = 1:1000:size(xout,3)
%     plot3(uin(4,i), uin(5,i), uin(6,i),'bo');    % asv positions
%     plot3(uin(10,i), uin(11,i), uin(12,i),'ro'); % auv positions
%     plot3(xout(4,:,i), xout(5,:,i), xout(6,:,i), 'k--.','MarkerSize',10);
% 
%     pause(0.5)
% 
% end




end