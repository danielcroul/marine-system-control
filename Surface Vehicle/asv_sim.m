% asv_sim    Script for asv simulation under basic propeller rps input. 
%
% Calls:     asv_sim.m
%
% Author:    Daniel R. Croul
% Date:      26-10-2023
% Revisions: 

clear; clc; close all; 

% Inial simulation time, final simulation time, time step
t0 = 0; tf = 10000; h = 0.02; 
t = t0:h:tf; 
% Load workspace variables
asv_params; 
% Initialise state parameters
[xinit, ninit] = asv_init(t); 
% Call solvers
xout = ode4(@asv_dynamics,t0, h, tf, xinit, ninit,asv);
nu = xout(1:3,:); 
eta = xout(4:6,:); 
xout_euler = euler(@asv_dynamics,t0,h,tf,xinit,ninit,asv); 
nuE = xout_euler(1:3,:); 
etaE = xout_euler(4:6,:); 

% Comparison between Euler and Runge-Kutta
figure(1); 

subplot(611),plot(t,nu(1,:),'linewidt',2)
xlabel('time (s)'),title('Surge velocity (m/s)'),grid
hold on; 
subplot(611),plot(t,nuE(1,:),'r--','linewidt',2)

subplot(612),plot(t,nu(2,:),'linewidt',2)
xlabel('time (s)'),title('Sway velocity (m/s)'),grid
hold on; 
subplot(612),plot(t,nuE(2,:),'r--','linewidt',2)

subplot(613),plot(t,(180/pi)*nu(3,:),'linewidt',2)
xlabel('time (s)'),title('Yaw rate (deg/s)'),grid
hold on; 
subplot(613),plot(t,(180/pi)*nuE(3,:),'r--','linewidt',2)

subplot(614),plot(eta(1,:),eta(2,:),'linewidt',2); 
title('xy plot (m)'),grid
hold on; 
subplot(614),plot(etaE(1,:),etaE(2,:),'r--','linewidt',2); 

subplot(615),plot(t, sqrt(nu(1,:).^2+nu(2,:).^2),'linewidt',2);
xlabel('time (s)'),title('speed (m/s)'),grid
hold on; 
subplot(615),plot(t, sqrt(nuE(1,:).^2+nuE(2,:).^2),'r--','linewidt',2);

subplot(616),plot(t,(180/pi)*eta(3,:),'linewidt',2)
xlabel('time (s)'),title('yaw angle (deg)'),grid
hold on; 
subplot(616),plot(t,(180/pi)*etaE(3,:),'r--','linewidt',2)

figure(2)
plot3(eta(1,:),eta(2,:),zeros(1, length(eta(1,:)))); 
hold on; 
plot3(etaE(1,:),etaE(2,:),zeros(1, length(etaE(1,:))),'r--'); 