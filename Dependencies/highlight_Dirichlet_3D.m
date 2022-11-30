function highlight_Dirichlet_3D(mesh,params,u)

    nodes2coord = mesh.nodes2coord;
    if nargin==3
        nodes2coord(:,1) = nodes2coord(:,1) + u(1:3:end);
        nodes2coord(:,2) = nodes2coord(:,2) + u(2:3:end);
        nodes2coord(:,3) = nodes2coord(:,3) + u(3:3:end);
    end
    
    if params.show.Dirichlet.Full
        nodes2display.nodes{1} = mesh.nodes.Dirichlet{1};
    else
        nodes2display.nodes{1} = [];
    end
    if params.show.Dirichlet.Two
        nodes2display.nodes{2} = mesh.nodes.Dirichlet{2};
    else
        nodes2display.nodes{2} = [];
    end
    if params.show.Dirichlet.One
        nodes2display.nodes{3} = mesh.nodes.Dirichlet{3};
    else
        nodes2display.nodes{3} = [];
    end
    nodes2display.color{1} = params.show.Dstyle{1};
    nodes2display.color{2} = params.show.Dstyle{2};
    nodes2display.color{3} = params.show.Dstyle{3};
    
    show_cell_of_nodes(nodes2coord,nodes2display,params.show.PS,params.show.LW)
    
end