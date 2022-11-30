function show_mesh_elasticity_3D(params,mesh,u,densities)
if nargin<4
    densities=zeros(size(mesh.volumes));
end
u_matrix=reshape(u,3,numel(u)/3)';
% h=show_constant_scalar_3D(densities,mesh.nodes2coord,mesh.elems2nodes,u_matrix);
% h=show_mesh(elements,coordinates+nodalDisplacement);
show_mesh_elasticity_densities(params,mesh.elems2nodes,mesh.nodes2coord+u_matrix,mesh.nodes.Dirichlet); 
hold on
s = patch('Faces',mesh.bfaces2nodes,'Vertices',mesh.nodes2coord+u_matrix,...
        'FaceVertexCData',densities(mesh.bfaces2elems),'FaceColor','flat','EdgeColor','none');
alpha(s,.5);    
hold off

    

xlabel('x'); ylabel('y'); zlabel('z'); axis image;
end