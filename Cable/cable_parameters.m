% CABLE Parameters
%
% CABLE Parameters is a script that creates workspace variables for
% an underwater umbilical cable. 
%
% Parameter list - 
%
% This is a structure with the following fields: 
%
% L         Total cable length                          (1x1)
% E         Modulus of elasticity                       (1x1)
% rho       Cable density                               (1x1)
% d         Cross-sectional diameter                    (1x1)
% Cint      Internal damping coefficient                (1x1)
% Can       Transverse (normal) added mass coefficient  (1x1)
% Cat       Tangential added mass coefficient           (1x1)
% Cdn       Transverse (normal) drag coefficient        (1x1)
% Cdt       Tangential drag coefficient                 (1x1)
% A         Cable cross-sectional area                  (1x1)
%
% Notes: 
% SI units are used. 
%
constants;         % Load global constant workspace variables
%
% Intrinsic cable parameters
%
cable.L = 10;                       % Total cable length                     (m) 
cable.nsegs = 10;                   % Number of cable segments
cable.nnodes = cable.nsegs+1; 
cable.E = 6.437e10;                 % Modulus of elasticity                  (Pa)
cable.rho = 8297.67;                % Cable density                          (kg/m^3)
cable.d = 133.76/1000;              % Cable cross-sectional diameter         (m)
% 
% Coefficients
%
cable.Cint = 100;     % Internal damping coefficient (stress-per strain rate Pa-s)
cable.Can = 0.865;       % Added mass coefficient in normal (transverse) direction
cable.Cat = 0.269;      % Added mass coefficient in tangential direction
cable.Cdn = 1.08;       % Normal (transverse) drag coefficient
cable.Cdt = 0.213;      % Tangential drag coefficient
%
% Derived constants
%
cable.A = pi/4*(cable.d)^2;         % Cross-sectional area          (m^2)
cable.Lca = cable.L/cable.nsegs;    % Length of each cable segment  (m)