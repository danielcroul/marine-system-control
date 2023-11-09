function [] = asv_plot(t, xout)

nu = xout(1:3,:);       % [ u v r ]
eta = xout(4:6,:);      % [ x y psi ]

len = size(xout,1);     % number of states total

figure(1);
hold on;
grid on;
grid minor;

subplot(len,1,1);
plot(t,nu(1,:),'linewidth',2);
xlabel('time (s)');
title('surge velocity (m/s)')

subplot(len,1,2);
plot(t,nu(2,:),'linewidth',2);
xlabel('time (s)');
title('sway velocity (m/s)');

subplot(len,1,3);
plot(t,(180/pi)*nu(3,:),'linewidth',2);
xlabel('time (s)');
title('yaw rate (deg/s)');

subplot(len,1,4);
plot(eta(1,:),eta(2,:),'linewidth',2);
title('xy plot (m)');

subplot(len,1,5);
plot(t, sqrt(nu(1,:).^2 + nu(2,:).^2),'linewidth',2);
xlabel('time (s)');
title('speed (m/s)');

subplot(len,1,6);
plot(t,(180/pi)*eta(3,:),'linewidth',2)
xlabel('time (s)');
title('yaw angle (deg)');

figure(2);
hold on;
set(gca, 'ydir','reverse')
set(gca, 'zdir','reverse')
xlabel('x-axis (m)');
ylabel('y-axis (m)');
zlabel('z-axis (m)');
axis equal;
grid minor;
view(-65.9, 26.325)
plot3(eta(1,:),eta(2,:),zeros(1, length(eta)));

% Plot visualisation at equally spaced increments
for i = round(linspace(1, size(xout,2), 10))
    plotOrientation([eta(1,i), eta(2,i), 0],[0, 0, eta(3,i)]);
    plotCuboid(0.5, 0.5, 0.5, [eta(1,i), eta(2,i), 0], [0, 0, eta(3,i)]);
end


end