function densities = densGrad_from_u_z_linear(mesh,params,u)  % 'u' must be displacement
    z = ones(mesh.nn,1);
    if nargin<3
        u = zeros(params.nbfn*mesh.nn,1);
    end
    % displacement to deformation
    u(1:3:end) = u(1:3:end) + mesh.nodes2coord(:,1);
    u(2:3:end) = u(2:3:end) + mesh.nodes2coord(:,2);
    u(3:3:end) = u(3:3:end) + mesh.nodes2coord(:,3);
    v_cell = createCellFromVector(u,mesh.dim);
    v_elems = CellAtMatrixOfIndices(v_cell,mesh.elems2nodes);
    F_elems = evaluate_F(mesh,v_elems);
    z_elems = evaluate_average(mesh.elems2nodes,z);
    params.lambdas = params.material.lambda*z_elems;
    params.mus = params.material.mu*z_elems;
    densities = densityGradientVector_2D_linear(F_elems,params);
end