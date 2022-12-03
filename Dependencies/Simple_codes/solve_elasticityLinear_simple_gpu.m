% solve_elasticityLinear_gpu_simple.m
function [u_init] = solve_elasticityLinear_simple_gpu(mesh,params,f_v) 
    u_init = zeros(params.nbfn*mesh.nn,1,'gpuArray'); 
    z = ones(mesh.nn,1,'gpuArray');
    
    K = stiffness_matrixP1_3D_elasticity_gpu(mesh.elems2nodes,mesh.nodes2coord,params.material.lambda,params.material.mu);
    M = mass_matrixP1_3D_vector_gpu(mesh.elems2nodes,mesh.volumes);
    
    b = evaluate_loading_vector(mesh,f_v,params.nbfn,M,z);
    
    bModif = b-K*u_init;
    dofsMinim = gpuArray(mesh.dofs.Minim);
    clear mesh M z % Clear memory for memory heavy operation
    K = gather(K);
    K_dofs = gpuArray(K(dofsMinim,dofsMinim));
    clear K % Clear memory for memory heavy operation
    u_init(dofsMinim) = u_init(dofsMinim)+K_dofs\bModif(dofsMinim);
end