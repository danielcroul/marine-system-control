% BLUEROV Parameters
%
% BLUEROV Parameters is a script that creates workspace variables for
% dynamic characteristics of the BlueROV2. 
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
brov.L = 0.457;         % Length                            (m)                     
brov.g = 9.81;          % Gravity                           (m/s^2)                 
brov.xG = 0;            % xCOG relative to Ob               (m)        
brov.yG = 0;            % yCOG relative to Ob               (m)         
brov.zG = 0;            % zCOG relative to Ob               (m)         
brov.xB = 0;            % xCOB relative to COG              (m)         
brov.yB = 0;            % yCOB relative to COG              (m)         
brov.zB = -0.01;        % zCOB relative to COG              (m)        
brov.rho = 1000;        % Water density                     (kg/m^3)          
brov.m = 13.5;          % Mass                              (kg)                       
brov.vfd = 0.0134;      % Volumetric fluid displacement     (m^3) 
brov.Ix = 0.26;         % xMOI                              (kg.m^2)                  
brov.Iy = 0.23;         % yMOI                              (kg.m^2)                  
brov.Iz = 0.37;         % zMOI                              (kg.m^2)                  
% 
% Hydrodynamic derivatives
%
brov.Xu = 13.7;
brov.Xuu = 141; 
brov.Xudot = 6.36; 

brov.Yv = 0; 
brov.Yvv = 217; 
brov.Yvdot = 7.12; 

brov.Zw = 33; 
brov.Zww = 190; 
brov.Zwdot = 18.68; 

brov.Kp = 0; 
brov.Kpp = 1.19; 
brov.Kpdot = 0.189; 

brov.Mq = 0.8; 
brov.Mqq = 0.47; 
brov.Mqdot = 0.135; 

brov.Nr = 0; 
brov.Nrr = 1.5; 
brov.Nrdot = 0.222; 
%
% Derived constants
%
brov.W   = brov.m*brov.g;                     % Weight            (N) 
brov.B   = brov.rho*brov.g*brov.vfd;          % Buoyancy          (N) 
brov.I   = diag([brov.Ix brov.Iy brov.Iz]);   % Inertia tensor 
brov.cog = [brov.xG brov.yG brov.zG];         % COB vector 