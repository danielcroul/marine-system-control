% AUV Parameters
%
% AUV Parameters is a script that creates workspace variables for
% dynamic characteristics of an AUV.  
%
% Parameter list - 
% 
% This is a structure with the following fields: 
%
% L     Vehicle length                      (1x1)
% xG    COG relative to Ob                  (1x1)
% yG    COG relative to Ob                  (1x1)
% zG    COG relative to Ob                  (1x1)
% xB    COB relative to COG                 (1x1) 
% yB    COB relative to COG                 (1x1)
% zB    COB relative to COG                 (1x1)
% rho   Water density                       (1x1)
% m     Vehicle mass                        (1x1) 
% vfd   Volumetric fluid displacement       (1x1)
% Ix    MOI                                 (1x1) 
% Iy    MOI                                 (1x1)
% Iz    MOI                                 (1x1)
%
% List of hydrodynamic derivative fields
% Xu, Xuu, Xudot
% Yv, Yvv, Yvdot
% Zw, Zww, Zwdot
% Kp, Kpp, Kpdot
% Mq, Mqq, Mqdot
% Np, Npp, Npdot
%
% List of calculated constants
% W     Weight                              (1x1)
% B     Buoyancy                            (1x1)
% I     Inertia tensor                      (3x3)
% cog   Centre-of-gravity vector            (1x3)
%
% Notes: 
% SI units are used. 
%
constants;             % Load global constant workspace variables
auv.L = 0.457;         % Length                            (m)                                  
auv.xG = 0;            % xCOG relative to Ob               (m)        
auv.yG = 0;            % yCOG relative to Ob               (m)         
auv.zG = 0;            % zCOG relative to Ob               (m)         
auv.xB = 0;            % xCOB relative to COG              (m)         
auv.yB = 0;            % yCOB relative to COG              (m)         
auv.zB = -0.01;        % zCOB relative to COG              (m)                 
auv.m = 13.5;          % Mass                              (kg)                       
auv.vfd = 0.0134;      % Volumetric fluid displacement     (m^3) 
auv.Ix = 0.26;         % xMOI                              (kg.m^2)                  
auv.Iy = 0.23;         % yMOI                              (kg.m^2)                  
auv.Iz = 0.37;         % zMOI                              (kg.m^2)  
auv.Ypont = 0.126;     % (m)
auv.Umax = 3.2;        % (m/s)
% 
% Hydrodynamic derivatives
%
auv.Xu = -13.7;
auv.Xuu = -141; 
auv.Xudot = -6.357; 

auv.Yv = 0; 
auv.Yvv = -217; 
auv.Yvdot = -7.121; 

auv.Zw = -33; 
auv.Zww = -190; 
auv.Zwdot = -18.69; 

auv.Kp = 0; 
auv.Kpp = -1.192; 
auv.Kpdot = -0.1858; 

auv.Mq = -0.8; 
auv.Mqq = -0.47; 
auv.Mqdot = -0.1348; 

auv.Nr = 0; 
auv.Nrr = -1.5; 
auv.Nrdot = -0.2215; 
%
% Derived constants
%
auv.W   = auv.m*const.g;                     % Weight            (N) 
auv.B   = const.rho*const.g*auv.vfd;         % Buoyancy          (N) 
auv.I   = diag([auv.Ix auv.Iy auv.Iz]);      % Inertia tensor    (kg.m^2)
auv.cog = [auv.xG auv.yG auv.zG]';           % COG vector        (m)
%
% Propeller Information 
%
auv.l1 = -auv.Ypont;                                    % Lever arm (left propeller) (m)
auv.l2 = auv.Ypont;                                     % Lever arm (right propeller) (m)
auv.k_pos = 0.02216/2;                                  % Positive Bollard, one propeller 
auv.k_neg = 0.01289/2;                                  % Negative Bollard, one propeller 
auv.n_max =  sqrt((0.5*24.4 * const.g)/auv.k_pos);      % Maximum propeller rev. (rad/s)
auv.n_min = -sqrt((0.5*13.6 * const.g)/auv.k_neg);      % Minimum propeller rev. (rad/s) 