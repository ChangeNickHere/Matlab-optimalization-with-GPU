fprintf("example_1_gpuArrayDeclaration started.\n")
X = [1 2 3 4 5];
X_GPU = gpuArray(X);

Z = gather(X_GPU);
fprintf("example_1_gpuArrayDeclaration completed.\n")