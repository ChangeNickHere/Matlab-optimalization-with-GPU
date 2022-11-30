function F = evaluate_F(mesh,v_elems)
% all deformation gradients from displacements
F = cell(numel(v_elems),numel(v_elems));
for d=1:numel(v_elems)
    for dim=1:numel(v_elems)
        F{d,dim} = sum(v_elems{d}.*mesh.dphi{dim},2);
    end
end
end