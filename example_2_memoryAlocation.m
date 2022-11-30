% example_2_memoryAlocation.m
fprintf("example_2_memoryAlocation started.\n")
t = tic; % zmena velikosti
a = 1; a(2) = 2;
a(3) = 3; a(4) = 4;
tr = toc(t);
fprintf("Array resize time %f.\n",tr)
t = tic; % pred-alokace
b = zeros(4,1);
b(1) = 1;  b(2) = 2; b(3) = 3; b(4) = 4;
ta = toc(t);
fprintf("Array alocate time %f.\n",ta)
fprintf("example_2_memoryAlocation completed.\n")