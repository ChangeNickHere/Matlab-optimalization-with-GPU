function show_mesh_3D(elems2nodes,nodes2coord,boundary2nodes,color_faces,bfaces2nodes)
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
end
axis on; axis tight;
xlabel('x'); ylabel('y'); zlabel('z'); axis image;
set(get(gca,'zlabel'),'rotation',0)
