function v_cell = createCellFromVector(v,dim)
v_cell = cell(dim,1);
for i=1:dim
    v_cell{i}=v(i:dim:end);
end 
end

