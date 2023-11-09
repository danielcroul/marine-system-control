% asv_sim    Script for asv simulation under basic propeller rps input. 
%
% Calls:     asv_sim.m
%
% Author:    Daniel R. Croul
% Date:      26-10-2023
% Revisions: 

clear; clc; close all; 

% Inial simulation time, final simulation time, time step
t0 = 0; tf = 100; h = 0.02; 
t = t0:h:tf; 
% Load workspace variables
asv_params; 
% Initialise state parameters
[xinit, ninit] = asv_init(t); 
% Call solvers
xout = ode4(@asv_dynamics,t0, h, tf, xinit, ninit,asv);
% nu = xout(1:3,:); 
% eta = xout(4:6,:); 
% xout_euler = euler(@asv_dynamics,t0,h,tf,xinit,ninit,asv); 
% nuE = xout_euler(1:3,:); 
% etaE = xout_euler(4:6,:); 

% Produce plot
asv_plot(t, xout); 