% mass_matrixP1_3D_gpu.m
elements = gpuArray(elements);
volumes = gpuArray(volumes);

Xscalar=kron(ones(1,4,'gpuArray'),elements); 
Yscalar=kron(elements,ones(1,4,'gpuArray')); 
Z=kron(volumes,gpuArray(reshape((ones(4)+eye(4))/20,1,16))); 
M=sparse(Xscalar,Yscalar,Z);