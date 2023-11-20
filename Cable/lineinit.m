function [x_ode4, ui_ode4] = lineinit(t, h, cable, string)

% Initialise internal node velocities
node_velocities = zeros(3, cable.nsegs-1);

switch(string)
    % asv-auv stationary
    case 'case1'
        % Initialise location of internal cable nodes along cable length
        node_positions = zeros(3,cable.nsegs-1);
        node_positions(3,1) = cable.Lca;

        for i = 1:cable.nsegs-2
            node_positions(3,i+1) = node_positions(3,i) + cable.Lca;
        end

        % State vector x[i] = [ xdot[i] ydot[i] zdot[i] x[i] y[i] z[i] ]
        x_ode4 = [node_velocities; node_positions];

        % Input ui = [ASV(xdot ydot zdot x y z) AUV(xdot ydot zdot x y z)]
        ui = [zeros(6,1); zeros(6,1)];
        ui(end) = cable.L;

        % Add velocities to asv and auv (constant)
        ui(1) = 0; ui(7) = 0;

        % Update asv-auv positions based on timestep
        ui_ode4 = ui;
        for i = 1:length(t)
            ui([4:6, 10:12]) = ui([4:6, 10:12]) + h*ui([1:3, 7:9]);
            ui_ode4 = [ui_ode4 ui];
        end


        % asv-auv constant velocity
    case 'case2'
        % Initialise location of internal cable nodes along cable length
        node_positions = zeros(3,cable.nsegs-1);
        node_positions(3,1) = cable.Lca;

        for i = 1:cable.nsegs-2
            node_positions(3,i+1) = node_positions(3,i) + cable.Lca;
        end

        % State vector x[i] = [ xdot[i] ydot[i] zdot[i] x[i] y[i] z[i] ]
        x_ode4 = [node_velocities; node_positions];

        % Input ui = [ASV(xdot ydot zdot x y z) AUV(xdot ydot zdot x y z)]
        ui = [zeros(6,1); zeros(6,1)];
        ui(end) = cable.L;

        % Add velocities to asv and auv (constant)
        ui(1) = 1; ui(7) = 1;

        % Update asv-auv positions based on timestep
        ui_ode4 = ui;
        for i = 1:length(t)
            ui([4:6, 10:12]) = ui([4:6, 10:12]) + h*ui([1:3, 7:9]);
            ui_ode4 = [ui_ode4 ui];
        end




        % asv rotation, auv stationary
    case 'case3'
        % Generate ASV data (5 m radius circle)
        % Positions
        theta = linspace(0,2*pi,length(t));
        r = 5;
        x = r*cos(theta);
        y = r*sin(theta);
        z = zeros(1,length(x));
        % Velocities
        xdot = diff(x) * h;
        xdot = [xdot xdot(1)];
        ydot = diff(y) * h;
        ydot = [ydot ydot(1)];
        zdot = zeros(1,length(z));
        asv_data = [xdot' ydot' zdot' x' y' z' ]';
        % Generate AUV data (stationary)
        auv_data = zeros(size(asv_data,1),size(asv_data,2));
        auv_data(6,:) = sqrt(cable.L^2 - r^2);

        % Combine asv-auv data
        ui_ode4 = [asv_data; auv_data];

        % Initialise location of node positions (via
        % interpolation)
        node_positions = zeros(3, cable.nsegs-1);
        npoints = linspace(0,cable.L,cable.nsegs+1);
        node_positions = interp1([0 cable.L], [ui_ode4(4:6); ui_ode4(10:12)], npoints)';
        % Extract internal node positions
        node_positions  = node_positions(:,2:end-1);

        % Initialise node velocities
        node_velocities = zeros(3,cable.nsegs-1);

        % State vector
        x_ode4 = [node_velocities; node_positions];


        % auv rotation, auv stationary
    case 'case4'
        % Generate AUV data (5 m radius circle)
        % Positions
        theta = linspace(0,2*pi,length(t));
        r = 5;
        x = r*cos(theta);
        y = r*sin(theta);
        z = ones(1,length(x))*sqrt(cable.L^2 - r^2);
        % Velocities
        xdot = diff(x) * h;
        xdot = [xdot xdot(1)];
        ydot = diff(y) * h;
        ydot = [ydot ydot(1)];
        zdot = zeros(1,length(z));
        auv_data = [xdot' ydot' zdot' x' y' z' ]';
        % Generate ASV data (stationary)
        asv_data = zeros(size(auv_data,1),size(auv_data,2));

        % Combine asv-auv data
        ui_ode4 = [asv_data; auv_data];

        % Initialise location of node positions (via
        % interpolation)
        node_positions = zeros(3, cable.nsegs-1);
        npoints = linspace(0,cable.L,cable.nsegs+1);
        node_positions = interp1([0 cable.L], [ui_ode4(4:6); ui_ode4(10:12)], npoints)';
        % Extract internal node positions
        node_positions  = node_positions(:,2:end-1);

        % Initialise node velocities
        node_velocities = zeros(3,cable.nsegs-1);

        % State vector
        x_ode4 = [node_velocities; node_positions];


        % asv-auv rotation
    case 'case5'
        % Generate ASV-AUV data (5 m radius circle)
        % Positions
        theta = linspace(0,2*pi,length(t));
        r = 5;
        x = r*cos(theta);
        y = r*sin(theta);
        zasv = zeros(1,length(x)); 
        % zauv = ones(1,length(x))*sqrt(cable.L^2 - r^2);
        zauv = ones(1,length(x))*cable.L; 
        % Velocities
        xdot = diff(x) * h;
        xdot = [xdot xdot(1)];
        ydot = diff(y) * h;
        ydot = [ydot ydot(1)];
        zdot = zeros(1,length(zasv));
        asv_data = [xdot' ydot' zdot' x' y' zasv']'; 
        auv_data = [xdot' ydot' zdot' x' y' zauv' ]'; 
        % Combine asv-auv data
        ui_ode4 = [asv_data; auv_data];

        % Initialise location of node positions (straight line)
        node_positions = zeros(3, cable.nsegs-1); 
        node_positions(:,1) = asv_data(4:6,1) + [0;0;cable.Lca]; 

        for i = 1:cable.nsegs-2
            node_positions(:,i+1) = node_positions(:,i) + [0;0;cable.Lca];
        end

        % Initialise node velocities
        node_velocities = zeros(3,cable.nsegs-1);

        % State vector
        x_ode4 = [node_velocities; node_positions];

    otherwise
        error('Input valid case number');

end






end