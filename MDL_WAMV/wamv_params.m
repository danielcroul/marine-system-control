% WAMV Parameters
%
% WAMV Parameters is a script that creates workspace variables for
% dynamic characteristics of the WAMV-16. 
%
% Parameter list - 
%
% This is a structure with the following fields: 
%
% L     Vehicle length                      (1x1)
% g     Gravity                             (1x1)
% xG    COG relative to Ob                  (1x1)
% yG    COG relative to Ob                  (1x1)
% zG    COG relative to Ob                  (1x1)
% m     Vehicle mass                        (1x1) 
% Ix    MOI                                 (1x1) 
% Iy    MOI                                 (1x1)
% Iz    MOI                                 (1x1)
%
% List of hydrodynamic derivative fields
% Xu, Xudot
% Yv, Yr, Yvdot, Yrdot
% Nv, Nr, Nvdot, Nrdot
%
% List of calculated constants
% W     Weight                              (1x1)
% B     Buoyancy                            (1x1)
% I     Inertia tensor                      (3x3)
%
% Notes: 
% SI units are used. 
%
wamv.L = 5;         % Length                    (m)                      
wamv.g = 9.81;      % Gravity                   (m/s^2)                 
wamv.xG = 0;        % xCOG relative to Ob       (m)         
wamv.yG = 0;        % yCOG relative to Ob       (m)        
wamv.zG = 0;        % zCOG relative to Ob       (m)        
wamv.m = 325;       % Mass                      (kg)                     
wamv.Ix = 0;        % xMOI                      (kg.m^2)                  
wamv.Iy = 0;        % yMOI                      (kg.m^2)                  
wamv.Iz = 592.17;   % zMOI                      (kg.m^2)                 
% 
% Hydrodynamic derivatives
%
wamv.Xu = -0.041; 
wamv.Xudot = 1.164; 

wamv.Yv = -34.87; 
wamv.Yr = 26.101; 
wamv.Yvdot = -1.241; 
wamv.Yrdot = 11.751; 

wamv.Nv = -50.085; 
wamv.Nr = 36.722; 
wamv.Nvdot = 5.220; 
wamv.Nrdot = -17.486; 
