%% Velocity:

% Components of the Jacobian
dvx_dx = zeros(size(v_x));
dvx_dy = zeros(size(v_x));
dvy_dx = zeros(size(v_y));
dvy_dy = zeros(size(v_y));

% Assuming linear spacing
dx = abs(x_mesh(1,2) - x_mesh(1,1));
dy = abs(y_mesh(2,1) - y_mesh(1,1));

% Central difference where possible
dvx_dx(:,2:end-1) = (v_x(:,1:end-2) - v_x(:,3:end))/...
                    (-2*dx);

dvx_dy(2:end-1,:) = (v_x(1:end-2,:) - v_x(3:end,:))/...
                    (-2*dy);

dvy_dx(:,2:end-1) = (v_y(:,1:end-2) - v_y(:,3:end))/...
                    (-2*dx);

dvy_dy(2:end-1,:) = (v_y(1:end-2,:) - v_y(3:end,:))/...
                    (-2*dy);


% Right-hand and left-hand difference on edge-cases

dvx_dx(:,1)   = (-3*v_x(:,1)   +4*v_x(:,2)     - v_x(:,3))/...
                (2*dx);

dvx_dx(:,end) = (3*v_x(:,end)  -4*v_x(:,end-1) + v_x(:,end-2))/...
                (2*dx);

dvy_dx(:,1)   = (-3*v_y(:,1)   +4*v_y(:,2)     - v_y(:,3))/...
                (2*dx);

dvy_dx(:,end) = (3*v_y(:,end)  -4*v_y(:,end-1) + v_y(:,end-2))/...
                (2*dx);



dvx_dy(:,1)   = (-3*v_x(1,:)   +4*v_x(2,:)     - v_x(3,:))/...
                (2*dy);

dvx_dy(:,end) = (3*v_x(end,:)  -4*v_x(end-1,:) + v_x(end-2,:))/...
                (2*dy);

dvy_dy(:,1)   = (-3*v_y(1,:)   +4*v_y(2,:)     - v_y(3,:))/...
                (2*dy);

dvy_dy(:,end) = (3*v_y(end,:)  -4*v_y(end-1,:) + v_y(end-2,:))/...
                (2*dy);

dvx_dx = relu(dvx_dx, 100);
dvx_dy = relu(dvx_dy, 100);
dvy_dx = relu(dvy_dx, 100);
dvy_dy = relu(dvy_dy, 100);
% max(abs([ ...
% max(dvx_dx,[], "all"),...
% max(dvy_dx,[], "all"),...
% max(dvx_dy,[], "all"),...
% max(dvy_dy,[], "all"),...
% min(dvx_dx,[], "all"),...
% min(dvy_dx,[], "all"),...
% min(dvx_dy,[], "all"),...
% min(dvy_dy,[], "all")]))

%% Mass:

% Components of the mass-Jacobian
dm_dx = zeros(size(mass));
dm_dy = zeros(size(mass));

% Assuming linear spacing
dx = abs(x_mesh(1,2) - x_mesh(1,1));
dy = abs(y_mesh(2,1) - y_mesh(1,1));

% Central difference where possible
dm_dx(:,2:end-1) = (mass(:,1:end-2) - mass(:,3:end))/...
                   (-2*dx);

dm_dy(2:end-1,:) = (mass(1:end-2,:) - mass(3:end,:))/...
                   (-2*dy);



%Right-hand and left-hand difference on edge-cases

dm_dx(:,1)   = (-3*mass(:,1)   +4*mass(:,2)     - mass(:,3))/...
              (2*dx);

dm_dx(:,end) = (3*mass(:,end)  -4*mass(:,end-1) + mass(:,end-2))/...
              (2*dx);



dm_dy(:,1)   = (-3*mass(1,:)   +4*mass(2,:)     - mass(3,:))/...
              (2*dy);

dm_dy(:,end) = (3*mass(end,:)  -4*mass(end-1,:) + mass(end-2,:))/...
              (2*dy);

dm_dx = relu(dm_dx, 2);
dm_dy = relu(dm_dy, 2);

max(abs( ...
    [max(dm_dx, [], "all"),...
     max(dm_dy, [], "all"),...
     min(dm_dx, [], "all"),...
     min(dm_dy, [], "all"),...
     ]))

% 
% max(abs([ ...
% max(dvx_dx,[], "all"),...
% max(dvy_dx,[], "all"),...
% max(dvx_dy,[], "all"),...
% max(dvy_dy,[], "all"),...
% min(dvx_dx,[], "all"),...
% min(dvy_dx,[], "all"),...
% min(dvx_dy,[], "all"),...
% min(dvy_dy,[], "all")]))
% 
% 
% 
