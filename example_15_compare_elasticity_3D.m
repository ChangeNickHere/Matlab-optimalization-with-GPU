
% commented because start_examples will provide data
% lvl = [1,2,3,4,5]
fprintf("compare_elasticity_3D started.\n")
for i = 1:numel(lvl)
    paramsMesh.level = lvl(i);
    
    cpu_elasticity = tic;
    solve_elasticity_3D_simple
    timeCPU = toc(cpu_elasticity);
    fprintf('LVL %.2f: elasticity CPU time: %.3f\n', lvl(i), timeCPU)
    
%     paramsMesh.level = lvl(i);
%     gpu_elasticity = tic;
%     solve_elasticity_3D_simple_gpu
%     timeGPU = toc(gpu_elasticity);
%     fprintf('LVL %.2f: elasticity GPU time: %.3f\n', lvl(i), timeGPU)
end 
fprintf("compare_elasticity_3D completed.\n")