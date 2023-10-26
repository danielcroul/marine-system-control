% auv_sim       Script for auv simulation under basic propeller rps input. 
%
% Calls:        auv_sim.m
%
% Author:       Daniel R. Croul
% Date:         26-10-2023
% Revisions: 

clear; clc; close all; 

% Inial simulation time, final simulation time, time step
t0 = 0; tf = 1000; h = 0.02; 
t = t0:h:tf; 
% Load workspace variables
auv_params; 
% Initialise state parameters
[xinit, ninit] = auv_init(t); 
% Call solvers
xout = ode4(@auv_dynamics,t0, h, tf, xinit, ninit,auv);
nu = xout(1:6,:); 
eta = xout(7:12,:); 
xout_euler = euler(@auv_dynamics,t0,h,tf,xinit,ninit,auv); 
nuE = xout_euler(1:6,:); 
etaE = xout_euler(7:12,:); 

%%
% Comparison between Euler and Runge-Kutta
figure(1); 
subplot(611),plot(t,nu(1,:),'linewidt',2)
grid on; 
xlabel('time (s)'),title('Surge velocity (m/s)'),grid
hold on; 
subplot(611),plot(t,nuE(1,:),'r--','linewidt',2)
grid on; 

subplot(612),plot(t,nu(2,:),'linewidt',2)
grid on; 
xlabel('time (s)'),title('Sway velocity (m/s)'),grid
hold on; 
subplot(612),plot(t,nuE(2,:),'r--','linewidt',2)
grid on; 

subplot(613),plot(t,(180/pi)*nu(3,:),'linewidt',2)
grid on; 
xlabel('time (s)'),title('Yaw rate (deg/s)'),grid
hold on; 
subplot(613),plot(t,(180/pi)*nuE(3,:),'r--','linewidt',2)
grid on; 

subplot(614),plot(eta(1,:),eta(2,:),'linewidt',2); 
grid on; 
title('xy plot (m)'),grid
hold on; 
subplot(614),plot(etaE(1,:),etaE(2,:),'r--','linewidt',2); 
grid on; 

subplot(615),plot(t, sqrt(nu(1,:).^2+nu(2,:).^2),'linewidt',2);
grid on; 
xlabel('time (s)'),title('speed (m/s)'),grid
hold on; 
subplot(615),plot(t, sqrt(nuE(1,:).^2+nuE(2,:).^2),'r--','linewidt',2);
grid on; 

subplot(616),plot(t,(180/pi)*eta(3,:),'linewidt',2)
grid on; 
xlabel('time (s)'),title('yaw angle (deg)'),grid
hold on; 
subplot(616),plot(t,(180/pi)*etaE(3,:),'r--','linewidt',2)
grid on; 

figure(2)
plot3(eta(1,:),eta(2,:),eta(3,:)); 
grid on; 
hold on; 
plot3(etaE(1,:),etaE(2,:),etaE(3,:),'r--'); 
grid on; 
xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis'); title('xyz plot')