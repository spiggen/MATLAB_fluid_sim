

[x_mesh, y_mesh] = meshgrid(x_vec,y_vec);

v_x = x_mesh*0;
v_y = y_mesh*0;

mass = ones(size(x_mesh))*0.01;

is_solid = zeros(size(x_mesh));
