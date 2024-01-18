make_jacobian


[x_prev, y_prev] = arrayfun(@solve_for_previous_position, ...
                            dvx_dx, dvx_dy, ...
                            dvy_dx, dvy_dy, ...
                            x_mesh, y_mesh, ...
                            v_x,    v_y);







[v_x,v_y] = arrayfun(@linearise,      ...
                      dvx_dx, dvx_dy, ...
                      dvy_dx, dvy_dy, ...
                      v_x,    v_y,    ...
                      x_prev - x_mesh, y_prev - y_mesh);



%v_x = strange2zero(v_x);
%v_y = strange2zero(v_y);


mass = mass + dm_dx.*(x_prev - x_mesh) - 2*mass.*dvx_dx*dt + ...
              dm_dy.*(y_prev - y_mesh) - 2*mass.*dvy_dy*dt;  

%mass = strange2zero(mass);
mass(mass  < 9*pi) = 9*pi;
mass(12*pi < mass) = 12*pi;


v_x = v_x - 100000*dt.*dm_dx*dx./(dy.*mass);
v_y = v_y - 100000*dt.*dm_dy*dx./(dx.*mass);


v_x = strange2zero(v_x);
v_y = strange2zero(v_y);




function [prev_x,prev_y] = solve_for_previous_position(J_11, J_12, ...
                                                       J_21, J_22, ...
                                                       x_0,  y_0, ...
                                                       v_x0, v_y0)

% dt = evalin("base", "dt"); % <-- Not pretty but makes me not have to rewrite 10^30 inputs whenever I arrayfun dis bitch
% 
% Jacobian = [J_11,J_12;
%             J_21,J_22];
% 
% pos_vec  = [x_0; y_0 ];
% v_vec    = [v_x0;v_y0];
% 
% 
% prev_pos = pos_vec - (eye(2) + Jacobian*dt)\v_vec*dt;
% prev_x = prev_pos(1);
% prev_y = prev_pos(2);


dt = 0.00001;

J_11 = J_11*dt + 1;
J_12 = J_12*dt + 0;
J_21 = J_21*dt + 0;
J_22 = J_22*dt + 1;

D = J_11*J_22 - J_21*J_12;

prev_x = x_0 - (  J_22*v_x0 - J_12*v_y0)*dt/D;
prev_y = y_0 - (- J_21*v_x0 + J_11*v_y0)*dt/D;
end
