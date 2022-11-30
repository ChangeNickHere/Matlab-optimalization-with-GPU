
% commented because start_examples will provide data
% lvl = [1,2,3,4,5]
fprintf("compare_stiffness started.\n")
add_paths;
for i=1:numel(lvl)
    paramsMesh.level =  lvl(i);
    paramsMesh.diag = 3;
    paramsMesh.print_mesh_info = 0;
    [mesh.coordinates, mesh.elements] = mesh_cuboid(paramsMesh);
    
    
    fprintf('Mesh density level: %.2f, coordinates: %d, elements: %d\n', lvl(i), size(mesh.coordinates,1), size(mesh.elements,1))

    gpu = tic;
    stiffness_matrixP1_3D_gpu(mesh.elements,mesh.coordinates);
    timeGPU = toc(gpu);
    fprintf('LVL %d: GPU time: %.3f\n', lvl(i), timeGPU)

  
    cpu = tic;
    stiffness_matrixP1_3D(mesh.elements,mesh.coordinates);
    timeCPU = toc(cpu);
    fprintf('LVL %d: CPU time: %.3f\n', lvl(i), timeCPU)
end
fprintf("compare_stiffness completed.\n")


