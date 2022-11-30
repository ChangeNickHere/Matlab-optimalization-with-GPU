function [u_init] = solve_elasticityLinear_simple(mesh,params,f_v)
    u_init = zeros(params.nbfn*mesh.nn,1);
    z = ones(mesh.nn,1);
    
    K = stiffness_matrixP1_3D_elasticity(mesh.elems2nodes,mesh.nodes2coord,params.material.lambda,params.material.mu);
    M = mass_matrixP1_3D_vector(mesh.elems2nodes,mesh.volumes);
    %disp(size(K))
    b = evaluate_loading_vector(mesh,f_v,params.nbfn,M,z);
    
    bModif = b-K*u_init;
    dofsMinim = mesh.dofs.Minim;
    u_init(dofsMinim) = u_init(dofsMinim)+K(dofsMinim,dofsMinim)\bModif(dofsMinim);
end

