% example_3_memoryAlocationGPU.m
fprintf("example_3_memoryAlocationGPU started.\n")
t = tic; % zmena velikosti
a = 1; gpuArray(a);
a(2) = 2; a(3) = 3; a(4) = 4;
tr = toc(t);
fprintf("GPU array resize time %f.\n",tr)
t = tic; % pred-alokace
b = zeros(4,1,'gpuArray');
b(1) = 1;  b(2) = 2; b(3) = 3; b(4) = 4;
ta = toc(t);
fprintf("GPU array alocate time %f.\n",ta)
fprintf("example_3_memoryAlocationGPU completed.\n")