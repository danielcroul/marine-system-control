% auv_sim       Script for auv simulation under basic propeller rps input. 
%
% Calls:        auv_sim.m
%
% Author:       Daniel R. Croul
% Date:         26-10-2023
% Revisions: 

clear; clc; close all; 

% Inial simulation time, final simulation time, time step
t0 = 0; tf = 100; h = 0.02; 
t = t0:h:tf; 
% Load workspace variables
auv_params; 
% Initialise state parameters
[xinit, ninit] = auv_init(t); 
% Call solvers
xout = ode4(@auv_dynamics,t0, h, tf, xinit, ninit,auv);
% nu = xout(1:6,:); 
% eta = xout(7:12,:); 
% xout_euler = euler(@auv_dynamics,t0,h,tf,xinit,ninit,auv); 
% nuE = xout_euler(1:6,:); 
% etaE = xout_euler(7:12,:); 

% Produce plot
auv_plot(t,xout); 