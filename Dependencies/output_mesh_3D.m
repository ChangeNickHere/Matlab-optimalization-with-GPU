function mesh = output_mesh_3D(nodes2coord,elems2nodes,nodes,dofs,level,params)

dim = size(nodes2coord,2);  % problem dimension
nn = size(nodes2coord,1);
ne = size(elems2nodes,1);

% create edges 
[edges2nodes, edges2elems, ~, ~] = getEdges(elems2nodes);
% create faces
[faces2nodes, faces2elems, ~, ~] = getFaces(elems2nodes);
% if isfield(nodes,'Neumann')
%     IL = (edges2elems(:,2)==0);    %logical vector of boundary edges
%     edgesBoundary2nodes = edges2nodes(IL,:);  %all boundary edges
%     IL2 = sum(ismember(edgesBoundary2nodes,nodes.Neumann),2)==2; %logical vector of Neumann boundary edges
%     edgesNeumann2nodes = edgesBoundary2nodes(IL2,:);
%     vector = nodes2coord(edgesNeumann2nodes(:,2),:) - nodes2coord(edgesNeumann2nodes(:,1),:);
%     edgesNeumann2normal = [vector(:,2) -vector(:,1)];
% end

%all gradients
NLB = dim+1; %number of local basic functions, it must be known!
coord = zeros(dim,NLB,ne);
for d=1:dim
    for j=1:NLB
        coord(d,j,:) = nodes2coord(elems2nodes(:,j),d);
    end
end   
IP = [1/3;1/3;1/3]; [dphi,jac] = phider(coord,IP,'P1'); 
dphi = squeeze(dphi); %all gradients 
volumes = abs(squeeze(jac))/factorial(dim); %all areas
dphi_x = squeeze(dphi(1,:,:))'; 
dphi_y = squeeze(dphi(2,:,:))';
dphi_z = squeeze(dphi(3,:,:))';

mesh.dim = dim;
mesh.level = level;
mesh.nn = nn;
mesh.ne = ne;
mesh.elems2nodes = elems2nodes;
mesh.nodes2coord = nodes2coord;
% mesh.ne_x = length(find(mesh.nodes2coord(:,2)<1e-12)) -1;
% mesh.ne_y = length(find(mesh.nodes2coord(:,1)<1e-12)) -1;
mesh.volumes = volumes;
mesh.V = sum(volumes);
mesh.dphi{1} = dphi_x;
mesh.dphi{2} = dphi_y;
mesh.dphi{3} = dphi_z;
% mesh.Hstr = sparsity_pattern(edges2nodes);   %sparsity pattern
if isfield(nodes,'FullDirichlet')
    mesh.nodes.Dirichlet{1} = nodes.FullDirichlet;
end
if isfield(nodes,'DirichletTwo')
    mesh.nodes.Dirichlet{2} = nodes.DirichletTwo;
end
if isfield(nodes,'DirichletOne')
    mesh.nodes.Dirichlet{3} = nodes.DirichletOne;
end
% if isfield(nodes,'Neumann')
%     mesh.nodes.Neumann{1} = nodes.Neumann;
% end
mesh.nodes.Minim = unique(ceil(setdiff((1:params.nbfn*nn)',dofs.Dirichlet)/params.nbfn));
mesh.dofs.Dirichlet = dofs.Dirichlet;
mesh.dofs.Minim = setdiff((1:params.nbfn*nn)',dofs.Dirichlet);
mesh.dofs.Minim_local = evaluate_dofsMinim_local(mesh.dofs.Minim,mesh.nodes.Minim,params.nbfn);
mesh.edges2nodes = edges2nodes;
mesh.edges2elems = edges2elems;
mesh.faces2nodes = faces2nodes;
mesh.faces2elems = faces2elems;
% if isfield(nodes,'Neumann')
%     mesh.edgesNeumann2nodes = edgesNeumann2nodes;
%     mesh.edgesNeumann2normal = edgesNeumann2normal;
% end
mesh.nodes.boundary = unique(faces2nodes(faces2elems(:,2)==0,:));
[indices] = find(faces2elems(:,2)==0);
bfaces2elems = faces2elems(indices);
bfaces2nodes = faces2nodes(indices,:);
mesh.bfaces2elems = bfaces2elems;
mesh.bfaces2nodes = bfaces2nodes;

end
