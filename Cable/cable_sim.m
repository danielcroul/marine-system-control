% cable_sim   Script for cable simulation given known asv-auv motions 
%
% Calls:      cable_sim.m
%
% Author:    Daniel R. Croul
% Date:      20-11-2023
% Revisions: 

clear; clc; close all;

% Inial simulation time, final simulation time, time step
% Note: a timestep of 1e-4 is suitable fn or convergence with both lower and
% higher number of nodes
t0 = 0; tf = 5; h = 0.000125;
t = t0:h:tf;
% Load workspace variablese
cable_parameters; constants;
% Initialise asv-auv and internal node positions/velocities
[xin, uin] = lineinit(t,h,cable,'case5'); 
% Call solver
xout = ode4cable(@cable_dynamics,t0,h,tf,xin,uin,const,cable);

% Produce plot
cable_plot(t, uin, xout); 
