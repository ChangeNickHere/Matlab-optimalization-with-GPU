function [u_init, eElastic] = solve_elasticityLinear_gpu(mesh,params,f_v,z,u_init)  % 'u_init' must be displacement

dim = mesh.dim;
if nargin<5
    u_init = zeros(params.nbfn*mesh.nn,1,'gpuArray');
    if nargin<4
        z = ones(mesh.nn,1, 'gpuArray');
        if nargin<3
            f_v = zeros(params.nbfn*mesh.nn,1, 'gpuArray');
        end
    end
end

z_elems = evaluate_average(z,mesh.elems2nodes);
lambda_elems = params.material.lambda*z_elems;
mu_elems = params.material.mu*z_elems;

if dim==2
    K = stiffness_matrixP1_2D_elasticity(mesh.elems2nodes,mesh.nodes2coord,lambda_elems,mu_elems);
    M = mass_matrixP1_2D_elasticity(mesh.elems2nodes,mesh.areas);
else % dim==3
    K = stiffness_matrixP1_3D_elasticity_gpu(mesh.elems2nodes,mesh.nodes2coord,params.material.lambda,params.material.mu);
    M = mass_matrixP1_3D_vector_gpu(mesh.elems2nodes,mesh.volumes);
end
b_fz = evaluate_loading_vector(mesh,f_v,params.nbfn,M,z);
% b_g = evaluate_surface_traction_vector_2D(mesh,params);

b = b_fz;

bModif = b-K*u_init;
% nodesMinim = mesh.nodes.Minim;
% dofsMinim = unique([2*nodesMinim-1;2*nodesMinim]);
K = gather(K);
dofsMinim = mesh.dofs.Minim;
u_init(dofsMinim) = u_init(dofsMinim)+K(dofsMinim,dofsMinim)\bModif(dofsMinim);
eElastic = (1/2)*u_init'*K*u_init - b'*u_init;

end

