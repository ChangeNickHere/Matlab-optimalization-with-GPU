function b = evaluate_loading_vector(mesh,f_v,nbfn,M,z)
% right-hand side vector b
dim = mesh.dim;
nn = mesh.nn;
if nargin<5
    z = ones(nn,1);
    if nargin<4
        if dim==2
            M = mass_matrixP1_2D_elasticity(mesh.elems2nodes,mesh.areas);
        else % dim==3
            M = mass_matrixP1_3D_vector    (mesh.elems2nodes,mesh.areas);
        end
        if nargin<3
            nbfn = dim;
            if nargin<2
                f_v = zeros(nbfn*nn,1);
            end
        end
    end
end

zq = zeros(nbfn*nn,1);
for d=1:nbfn
    zq(d:nbfn:end) = z;
end
fz = zq.*f_v;
b = M*fz;

end
