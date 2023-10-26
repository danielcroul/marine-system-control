% asv Parameters
%
% asv Parameters is a script that creates workspace variables for
% dynamic characteristics of the asv-16. 
%
% Parameter list - 
%
% This is a structure with the following fields: 
%
% L     Vehicle length                      (1x1)
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
% Notes: 
% SI units are used. 
%
constants;         % Load global constant workspace variables
asv.L = 5;         % Length                    (m)                                     
asv.xG = 0;        % xCOG relative to Ob       (m)         
asv.yG = 0;        % yCOG relative to Ob       (m)        
asv.zG = 0;        % zCOG relative to Ob       (m)        
asv.m = 325;       % Mass                      (kg)                     
asv.Ix = 0;        % xMOI                      (kg.m^2)                  
asv.Iy = 0;        % yMOI                      (kg.m^2)                  
asv.Iz = 592.17;   % zMOI                      (kg.m^2)   
asv.Ypont = 1.225; % (m)
asv.Umax = 3.2;    % (m/s)
% 
% Hydrodynamic derivatives
%
asv.Xu = -24.4 * const.g / asv.Umax; 
asv.Xudot = 1.164; 

asv.Yv = -34.87; 
asv.Yr = 26.101; 
asv.Yvdot = -1.5 * asv.m; 
asv.Yrdot = 11.751; 

asv.Nv = -50.085; 
asv.Nvdot = 5.220; 
asv.Nrdot = -1.7 * asv.Iz; 
asv.Nr = -(asv.Iz - asv.Nrdot); 
%
% Propeller Information 
%
asv.l1 = -asv.Ypont;                                    % Lever arm (left propeller) (m)
asv.l2 = asv.Ypont;                                     % Lever arm (right propeller) (m)
asv.k_pos = 0.02216/2;                                  % Positive Bollard, one propeller 
asv.k_neg = 0.01289/2;                                  % Negative Bollard, one propeller 
asv.n_max =  sqrt((0.5*24.4 * const.g)/asv.k_pos);      % Maximum propeller rev. (rad/s)
asv.n_min = -sqrt((0.5*13.6 * const.g)/asv.k_neg);      % Minimum propeller rev. (rad/s) 