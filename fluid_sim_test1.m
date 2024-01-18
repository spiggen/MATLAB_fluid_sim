mypath = erase(mfilename("fullpath"), "\fluid sim 3\fluid_sim_test1")+"\";
addpath(mypath+"colorthemes")
addpath(mypath+"spiggens toolbox")
warning("off")


myax = axes();
fireflies();

dt = 0.00001;

x_vec = linspace(0,10,200);
y_vec = linspace(0,10,200);

initiate_fluid_field
%v_x = sin(x_mesh).*cos(y_mesh)*10;
%v_y = sin(y_mesh).*cos(y_mesh)*10;
mass(:,:) = pi*10;


while true
v_x(80:120,100:101) = - 10;
%mass(60:140, 100:120) = 10*pi + sin(linspace(0,pi,81)')*sin(linspace(0,2*pi, 21));
step_velocity



imagesc(myax, x_mesh(1, 1:end), y_mesh(1:end,1), log(mass));
myax.NextPlot = "add";
%quiver(myax,x_mesh(1:4:end,1:4:end), y_mesh(1:4:end, 1:4:end), v_x(1:4:end, 1:4:end),v_y(1:4:end, 1:4:end))
streamslice(myax,x_mesh(1:1:end,1:1:end), y_mesh(1:1:end, 1:1:end), v_x(1:1:end, 1:1:end),v_y(1:1:end, 1:1:end))
myax.NextPlot = "replacechildren";
xlim(myax, [0,10]);
ylim(myax, [0,10]);
colorbar(myax);
drawnow
end