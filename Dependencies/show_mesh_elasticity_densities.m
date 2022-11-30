function show_mesh_elasticity_densities(params,elems2nodes,nodes2coord,boundary2nodes,color_faces,bfaces2nodes)
if (size(elems2nodes,2)==3)   %2D triangles
    draw_mesh_2d(nodes2coord',elems2nodes','P1');
    if nargin==4
        hold on
        plot(nodes2coord(boundary2nodes,1),nodes2coord(boundary2nodes,2), 'ro', 'MarkerSize',10);
        hold off
    end
else  %tetrahedra
    if nargin<6
        [faces2nodes, faces2elems]=getFaces(elems2nodes);
        bfaces2faces_logic=faces2elems(:,2)==0;
        bfaces2nodes=faces2nodes(bfaces2faces_logic,:);
    end
    
    if nargin<5
       draw_mesh_3d(nodes2coord',bfaces2nodes','P1');
    else
       draw_mesh_3d(nodes2coord',bfaces2nodes','P1',color_faces);
    end   
       
    if nargin>=4
        hold on
        if numel(boundary2nodes)==1
            if params.show.Dirichlet.Full
                plot3(nodes2coord(boundary2nodes{1},1),nodes2coord(boundary2nodes{1},2),nodes2coord(boundary2nodes{1},3), 'ro', 'MarkerSize',8,'Linewidth',1.5);
            end
        else
            if params.show.Dirichlet.Full
                plot3(nodes2coord(boundary2nodes{1},1),nodes2coord(boundary2nodes{1},2),nodes2coord(boundary2nodes{1},3), 'ro', 'MarkerSize',8,'Linewidth',1.5);
            end
            if params.show.Dirichlet.Two
                plot3(nodes2coord(boundary2nodes{2},1),nodes2coord(boundary2nodes{2},2),nodes2coord(boundary2nodes{2},3), 'co', 'MarkerSize',8,'Linewidth',1.6);
            end
            if params.show.Dirichlet.One
                plot3(nodes2coord(boundary2nodes{3},1),nodes2coord(boundary2nodes{3},2),nodes2coord(boundary2nodes{3},3), 'go', 'MarkerSize',8,'Linewidth',1.8);
            end
        end
        hold off
    end
end
axis on; axis tight;
xlabel('x'); ylabel('y'); zlabel('z'); axis image;
set(get(gca,'zlabel'),'rotation',0)
