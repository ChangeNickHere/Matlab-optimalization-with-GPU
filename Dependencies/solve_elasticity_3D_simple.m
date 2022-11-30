params.material.E = 1e8;
params.material.nu = 0.2;

[n2c,e2n] = mesh_cuboid_sym(paramsMesh);      figure; figure_mesh(n2c,e2n,paramsMesh.level, 'original');

setup_parameters;
params.nbfn = 3;
params.show.PS = 6;

%==========================================================================================================
%FEM solution
nn = size(n2c,1);
ne = size(e2n,1);
[params.material.lambda, params.material.mu, params.material.K] = ...
        convert_from_E_nu(params.material.E,params.material.nu);
%===Boundary_conditions====================================================================================
params.BC.Dirichlet{1}.method = 'plane';
params.BC.Dirichlet{1}.plane = 'z';
params.BC.Dirichlet{1}.coord = 0;
params.BC.Dirichlet{1}.directions = [1 2 3];
params.BC.Dirichlet{1}.tol = 1e-12;
params.BC.nbfn = 3;
[logic_vector_D, logic_vector_N] = logic_vectors_3D(n2c,params.BC);
dofs.Dirichlet = find(logic_vector_D);
nodes.FullDirichlet = find((logic_vector_D(1:3:end)+logic_vector_D(2:3:end)+logic_vector_D(3:3:end))==3);
nodes.DirichletTwo  = find((logic_vector_D(1:3:end)+logic_vector_D(2:3:end)+logic_vector_D(3:3:end))==2);
nodes.DirichletOne  = find((logic_vector_D(1:3:end)+logic_vector_D(2:3:end)+logic_vector_D(3:3:end))==1);
nodes.Neumann       = find((logic_vector_N(1:3:end)+logic_vector_N(2:3:end)+logic_vector_N(3:3:end))==3);
%==========================================================================================================
mesh = output_mesh_3D(n2c,e2n,nodes,dofs,paramsMesh.level,params);
highlight_Dirichlet_3D(mesh,params);
%===Loading================================================================================================
force = 10e6;
f = zeros(params.nbfn*mesh.nn,1);
nodes_L = find(n2c(:,1)<0);
nodes_R = find(n2c(:,1)>0);
f(3*nodes_L-2) = +force;
f(3*nodes_R-2) = -force;

u = solve_elasticityLinear_simple(mesh,params,f);

n2c_new = n2c;
n2c_new(:,1) = n2c_new(:,1) +u(1:3:end);
n2c_new(:,2) = n2c_new(:,2) +u(2:3:end);
n2c_new(:,3) = n2c_new(:,3) +u(3:3:end);
figure;
figure_mesh(n2c_new,e2n, paramsMesh.level, 'deformed');
highlight_Dirichlet_3D(mesh,params);

% figure;
% densities = densGrad_from_u_z_linear(mesh,params,u);
% show_mesh_elasticity_3D(params,mesh,u,densities);
% colorbar;
%==========================================================================================================

function figure_mesh(n2c,e2n,lvl, desc)
    show_mesh_3D(e2n,n2c);
%     show_vertices(n2c);
    axis tight;
    %title(join(['Level = ' num2str(lvl) ' ' desc]));
end
