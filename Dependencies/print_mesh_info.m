function print_mesh_info(n2c,e2n)

    dim = size(n2c,2);
    fprintf('|T| = %d\n',size(e2n,1));
    [h_min,h_max] = h_of_elements(n2c,e2n);
    sizes = sizes_of_elements(n2c,e2n);
    angles = angles_of_elements(n2c,e2n);
    orientations = orientations_of_elements(n2c,e2n);
    fprintf('h: %.2f %.2f\n',h_min,h_max);
    if dim==2
        fprintf('angles: %.2f %.2f\n',min(min(angles)),max(max(angles)));
        fprintf('areas ratio: %.2f\n',max(sizes)/min(sizes));
        fprintf('total area: %.2f\n',sum(sizes));
    else % dim==3
        fprintf('angles ratio: %.2f\n',max(max(angles))/min(min(angles)));
        fprintf('volumes ratio: %.2f\n',max(sizes)/min(sizes));
        fprintf('total volume: %.2f\n',sum(sizes));
    end
    if min(orientations)==1
        fprintf('orientation: positive\n');
    elseif max(orientations)==-1
        fprintf('orientation: negative\n');
    else
        fprintf('orientation: mixed\n');
    end
    
end