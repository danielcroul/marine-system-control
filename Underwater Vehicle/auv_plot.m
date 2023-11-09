function [] = auv_plot(t, xout);


nu = xout(1:6,:); % [ u v w p q r ]
eta = xout(7:12,:); % [ x y z phi theta psi ]

len = size(xout,1); % number of states total


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
plot(t,nu(3,:), 'linewidth',2);
xlabel('time (s)');
title('heave velocity (m/s)');

subplot(len,1,4);
plot(t,(180/pi)*nu(4,:),'linewidth',2);
xlabel('time (s)');
title('roll rate (deg/s)');

subplot(len,1,5);
plot(t,(180/pi)*nu(5,:),'linewidth',2);
xlabel('time (s)');
title('pitch rate (deg/s)');

subplot(len,1,6);
plot(t,(180/pi)*nu(6,:),'linewidth',2);
xlabel('time (s)');
title('yaw rate (deg/s)');

subplot(len,1,7);
plot(eta(1,:),eta(2,:),'linewidth',2);
title('xy plot (m)');

subplot(len,1,8);
plot(t, sqrt(nu(1,:).^2 + nu(2,:).^2 + nu(3,:).^2),'linewidth',2);
xlabel('time (s)');
title('speed (m/s)');

subplot(len,1,9);
plot(t,(180/pi)*eta(4,:),'linewidth',2)
xlabel('time (s)');
title('roll angle (deg)');

subplot(len,1,10);
plot(t,(180/pi)*eta(5,:),'linewidth',2)
xlabel('time (s)');
title('pitch angle (deg)');

subplot(len,1,11);
plot(t,(180/pi)*eta(6,:),'linewidth',2)
xlabel('time (s)');
title('yaw angle (deg)');


figure(2);
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
plot3(eta(1,:),eta(2,:),eta(3,:));

for i = round(linspace(1, size(xout,2), 10))
    plotOrientation([eta(1,i), eta(2,i), eta(3,i)],[eta(4,i), eta(5,i), eta(6,i)]);
    plotCuboid(0.5, 0.5, 0.5, [eta(1,i), eta(2,i), eta(3,i)], [eta(4,i), eta(5,i), eta(6,i)]);
end


end


