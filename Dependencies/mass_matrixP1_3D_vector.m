function M=mass_matrixP1_3D_vector(elements,volumes)

Mscalar=mass_matrixP1_3D(elements,volumes);

[Iscalar,Jscalar,Kscalar]=find(Mscalar);

%Xscalar=kron(ones(1,4),elements); Yscalar=kron(elements,ones(1,4));
% Zscalar=kron(volumes,reshape((ones(4)+eye(4))/20,1,16));  % ORIGINAL
%Zscalar=kron(volumes,reshape((ones(4)+eye(4))/20/3,1,16));  % CORRECTED

Ivector=[3*Iscalar-2; 3*Iscalar-1; 3*Iscalar];
Jvector=[3*Jscalar-2; 3*Jscalar-1; 3*Jscalar];
Kvector=[Kscalar; Kscalar; Kscalar];
M=sparse(Ivector,Jvector,Kvector,3*size(Mscalar,1),3*size(Mscalar,2));
