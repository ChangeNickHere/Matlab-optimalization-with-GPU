function nodes_S = nodes_of_mesh(n2c,e2n,mesh_geometry,params)

dim = size(n2c,2);

[xyz_min,xyz_max] = minmax(n2c);
x_min = xyz_min(1);  x_max = xyz_max(1);
y_min = xyz_min(2);  y_max = xyz_max(2);
% if dim==3
%     z_min = xyz_min(3);  z_max = xyz_max(3);
% end
center = (xyz_min+xyz_max)/2;
x_c = center(1);  y_c = center(2);
% if dim==3
%     z_c = center(3);
% end

if dim==2
    switch mesh_geometry
        case 'rectangle'
            nodes_S.corner_BL = node_single(n2c,[x_min y_min]);
            nodes_S.corner_BR = node_single(n2c,[x_max y_min]);
            nodes_S.corner_TL = node_single(n2c,[x_min y_max]);
            nodes_S.corner_TR = node_single(n2c,[x_max y_max]);
            nodes_S.corners = sort([nodes_S.corner_BL; nodes_S.corner_BR; nodes_S.corner_TL; nodes_S.corner_TR]);
            nodes_S.edge_L = cross_section(n2c,'x',x_min);
            nodes_S.edge_R = cross_section(n2c,'x',x_max);
            nodes_S.edge_B = cross_section(n2c,'y',y_min);
            nodes_S.edge_T = cross_section(n2c,'y',y_max);
        case 'triangle'
            nodes_S.corner_BL = node_single(n2c,[x_min y_min]);
            nodes_S.corner_BR = node_single(n2c,[x_max y_min]);
            nodes_S.corner_TL = node_single(n2c,[x_min y_max]);
            nodes_S.corners = sort([nodes_S.corner_BL; nodes_S.corner_BR; nodes_S.corner_TL]);
            nodes_S.edge_L = cross_section(n2c,'x',x_min);
            nodes_S.edge_B = cross_section(n2c,'y',y_min);
            nodes_S.edges = unique([nodes_S.edge_L; nodes_S.edge_B]);
            % edge diag
        case 'square_hole'
            r = params.r;
            nodes_S.corner_BL = node_single(n2c,[x_min y_min]);
            nodes_S.corner_BR = node_single(n2c,[x_max y_min]);
            nodes_S.corner_TL = node_single(n2c,[x_min y_max]);
            nodes_S.corner_TR = node_single(n2c,[x_max y_max]);
            nodes_S.corners = sort([nodes_S.corner_BL; nodes_S.corner_BR; nodes_S.corner_TL; nodes_S.corner_TR]);
            nodes_S.edge_LO = cross_section(n2c,'x',x_min);
            nodes_S.edge_RO = cross_section(n2c,'x',x_max);
            nodes_S.edge_BO = cross_section(n2c,'y',y_min);
            nodes_S.edge_TO = cross_section(n2c,'y',y_max);
            nodes_S.edge_BI = nodes_interval(n2c,[x_c x_c; y_min y_c]);
            nodes_S.edge_TI = nodes_interval(n2c,[x_c x_c; y_max y_c]);
            nodes_S.edge_LI = nodes_interval(n2c,[x_min x_c; y_c y_c]);
            nodes_S.edge_RI = nodes_interval(n2c,[x_max x_c; y_c y_c]);
            nodes_S.edges_O = unique([nodes_S.edge_LO; nodes_S.edge_RO; nodes_S.edge_BO; nodes_S.edge_TO]);
            nodes_S.edges_I = unique([nodes_S.edge_LI; nodes_S.edge_RI; nodes_S.edge_BI; nodes_S.edge_TI]);
            nodes_S.edges = unique([nodes_S.edges_O; nodes_S.edges_I]);
            nodes_S.inside = nodes_ellipse(n2c,r,center);
        case 'L-shape_2D'
            wx = params.wx;  wy = params.wy;
            nodes_S.corner_BL  = node_single(n2c,[x_min y_min]);
            nodes_S.corner_BR  = node_single(n2c,[x_max y_min]);
            nodes_S.corner_TL  = node_single(n2c,[x_min y_max]);
            nodes_S.corner_BRI = node_single(n2c,[x_max y_min+wy]);
            nodes_S.corner_TLI = node_single(n2c,[x_min+wx y_max]);
            nodes_S.corner_I  = node_single(n2c,[x_min+wx y_min+wy]);
            nodes_S.corners = sort([nodes_S.corner_BL; nodes_S.corner_BR; nodes_S.corner_TL; nodes_S.corner_BRI; nodes_S.corner_TLI; nodes_S.corner_I]);
            nodes_S.edge_L  = cross_section(n2c,'x',x_min);
            nodes_S.edge_R  = cross_section(n2c,'x',x_max);
            nodes_S.edge_B  = cross_section(n2c,'y',y_min);
            nodes_S.edge_T  = cross_section(n2c,'y',y_max);
            nodes_S.edge_LI = nodes_interval(n2c,[x_min+wx x_min+wx; y_min+wy y_max]);
            nodes_S.edge_BI = nodes_interval(n2c,[x_min+wx x_max; y_min+wy y_min+wy]);
        case 'pincers_2D'
            wx = params.wx;  wy = params.wy;
            nodes_S.corner_BL  = node_single(n2c,[x_min y_min]);
            nodes_S.corner_BR  = node_single(n2c,[x_max y_min]);
            nodes_S.corner_TL  = node_single(n2c,[x_min y_max]);
            nodes_S.corner_TR  = node_single(n2c,[x_max y_max]);
            nodes_S.corner_BLI = node_single(n2c,[x_min+wx y_min+wy]);
            nodes_S.corner_BRI = node_single(n2c,[x_max y_min+wy]);
            nodes_S.corner_TLI = node_single(n2c,[x_min+wx y_max-wy]);
            nodes_S.corner_TRI = node_single(n2c,[x_max y_max-wy]);
            nodes_S.corners = sort([nodes_S.corner_BL;  nodes_S.corner_BR;  nodes_S.corner_TL;  nodes_S.corner_TR; ...
                                    nodes_S.corner_BLI; nodes_S.corner_BRI; nodes_S.corner_TLI; nodes_S.corner_TRI]);
            nodes_S.edge_L = cross_section(n2c,'x',x_min);
            nodes_S.edge_B = cross_section(n2c,'y',y_min);
            nodes_S.edge_T = cross_section(n2c,'y',y_max);
            nodes_S.edge_RB = nodes_interval(n2c,[x_max x_max; y_min y_min+wy]);
            nodes_S.edge_RT = nodes_interval(n2c,[x_max x_max; y_max y_max-wy]);
            nodes_S.edge_LI = nodes_interval(n2c,[x_min+wx x_min+wx; y_min+wy y_max-wy]);
            nodes_S.edge_LO = nodes_interval(n2c,[x_min    x_min;    y_min+wy y_max-wy]);
            nodes_S.edge_BI = nodes_interval(n2c,[x_min+wx x_max; y_min+wy y_min+wy]);
            nodes_S.edge_TI = nodes_interval(n2c,[x_min+wx x_max; y_max-wy y_max-wy]);
        case 'disk'
            nodes_S.pole_L = node_single(n2c,[x_min,y_c]);
            nodes_S.pole_R = node_single(n2c,[x_max,y_c]);
            nodes_S.pole_B = node_single(n2c,[x_c,y_min]);
            nodes_S.pole_T = node_single(n2c,[x_c,y_max]);
            nodes_S.poles  = unique([nodes_S.pole_L; nodes_S.pole_R; nodes_S.pole_B; nodes_S.pole_T]);
        case 'annulus'
            r = params.r;  R = params.R;
            if ~isfield(params,'a')  a = 1;  else  a = params.a;  end
            if ~isfield(params,'b')  b = 1;  else  b = params.b;  end
            nodes_S.pole_LO = node_single(n2c,[x_min,y_c]);
            nodes_S.pole_RO = node_single(n2c,[x_max,y_c]);
            nodes_S.pole_BO = node_single(n2c,[x_c,y_min]);
            nodes_S.pole_TO = node_single(n2c,[x_c,y_max]);
            nodes_S.pole_LI = node_single(n2c,[x_min+a*(R-r),y_c]);
            nodes_S.pole_RI = node_single(n2c,[x_max-a*(R-r),y_c]);
            nodes_S.pole_BI = node_single(n2c,[x_c,y_min+b*(R-r)]);
            nodes_S.pole_TI = node_single(n2c,[x_c,y_max-b*(R-r)]);
            nodes_S.poles_O = unique([nodes_S.pole_LO; nodes_S.pole_RO; nodes_S.pole_BO; nodes_S.pole_TO]);
            nodes_S.poles_I = unique([nodes_S.pole_LI; nodes_S.pole_RI; nodes_S.pole_BI; nodes_S.pole_TI]);
            nodes_S.poles   = unique([nodes_S.poles_O; nodes_S.poles_I]);
            nodes_S.inside  = nodes_ellipse(n2c,r,center,a,b);
            nodes_S.outside = nodes_ellipse(n2c,R,center,a,b);
            nodes_S.edge_BI = nodes_interval(n2c,[x_c x_c; y_min y_c]);
            nodes_S.edge_TI = nodes_interval(n2c,[x_c x_c; y_max y_c]);
            nodes_S.edge_LI = nodes_interval(n2c,[x_min x_c; y_c y_c]);
            nodes_S.edge_RI = nodes_interval(n2c,[x_max x_c; y_c y_c]);
            nodes_S.edges_I = unique([nodes_S.edge_LI; nodes_S.edge_RI; nodes_S.edge_BI; nodes_S.edge_TI]);
        case 'V-shape'
            nodes_S.corner_BO = node_single(n2c,[x_c y_min]);
            nodes_S.edge_C = cross_section(n2c,'x',x_c);
            y_max_c = max(n2c(nodes_S.edge_C,2));
            nodes_S.corner_BI = node_single(n2c,[x_c y_max_c]);
            nodes_S.corner_TLO = node_single(n2c,[x_min y_max]);
            nodes_S.corner_TRO = node_single(n2c,[x_max y_max]);
            nodes_S.edge_TL = cross_section(n2c,'x',x_min);
            nodes_S.edge_TR = cross_section(n2c,'x',x_max);
            y_min_TL = min(n2c(nodes_S.edge_TL,2));
            y_min_TR = min(n2c(nodes_S.edge_TR,2));
            nodes_S.corner_TLI = node_single(n2c,[x_min y_min_TL]);
            nodes_S.corner_TRI = node_single(n2c,[x_max y_min_TR]);
            nodes_S.corners = unique([nodes_S.corner_BO; nodes_S.corner_BI; nodes_S.corner_TLO; nodes_S.corner_TLI; nodes_S.corner_TRO; nodes_S.corner_TRI]);
            nodes_S.edges = unique([nodes_S.edge_C; nodes_S.edge_TL; nodes_S.edge_TR]);
        case 'W-shape_1'
            nodes_S.corner_TO = node_single(n2c,[x_c y_max]);
            nodes_S.edge_C = cross_section(n2c,'x',x_c);
            y_min_c = min(n2c(nodes_S.edge_C,2));
            nodes_S.corner_TI = node_single(n2c,[x_c y_min_c]);
            nodes_B = cross_section(n2c,'y',y_min);
            x_min_B = min(n2c(nodes_B,1));
            x_max_B = max(n2c(nodes_B,1));
            nodes_S.corner_BLO = node_single(n2c,[x_min_B y_min]);
            nodes_S.corner_BRO = node_single(n2c,[x_max_B y_min]);
            nodes_S.edge_BL = cross_section(n2c,'x',x_min_B);
            nodes_S.edge_BR = cross_section(n2c,'x',x_max_B);
            y_max_BL = max(n2c(nodes_S.edge_BL,2));
            y_max_BR = max(n2c(nodes_S.edge_BR,2));
            nodes_S.corner_BLI = node_single(n2c,[x_min_B y_max_BL]);
            nodes_S.corner_BRI = node_single(n2c,[x_max_B y_max_BR]);
            nodes_S.corner_TLO = node_single(n2c,[x_min y_max]);
            nodes_S.corner_TRO = node_single(n2c,[x_max y_max]);
            nodes_S.edge_TL = cross_section(n2c,'x',x_min);
            nodes_S.edge_TR = cross_section(n2c,'x',x_max);
            y_min_TL = min(n2c(nodes_S.edge_TL,2));
            y_min_TR = min(n2c(nodes_S.edge_TR,2));
            nodes_S.corner_TLI = node_single(n2c,[x_min y_min_TL]);
            nodes_S.corner_TRI = node_single(n2c,[x_max y_min_TR]);
            nodes_S.corners = unique([nodes_S.corner_TO; nodes_S.corner_BLO; nodes_S.corner_BRO; nodes_S.corner_TLO; nodes_S.corner_TRO; ...
                                      nodes_S.corner_TI; nodes_S.corner_BLI; nodes_S.corner_BRI; nodes_S.corner_TLI; nodes_S.corner_TRI]);
            nodes_S.edges = unique([nodes_S.edge_C; nodes_S.edge_BL; nodes_S.edge_BR; nodes_S.edge_TL; nodes_S.edge_TR]);
        case 'W-shape_2'
            nodes_S.corner_TO = node_single(n2c,[x_c y_max]);
            nodes_S.edge_C = cross_section(n2c,'x',x_c);
            y_min_c = min(n2c(nodes_S.edge_C,2));
            nodes_S.corner_TI = node_single(n2c,[x_c y_min_c]);
            nodes_B = cross_section(n2c,'y',y_min);
            x_min_B = min(n2c(nodes_B,1));
            x_max_B = max(n2c(nodes_B,1));
            nodes_S.corner_BLO = node_single(n2c,[x_min_B y_min]);
            nodes_S.corner_BRO = node_single(n2c,[x_max_B y_min]);
            nodes_S.edge_BL = cross_section(n2c,'x',x_min_B);
            nodes_S.edge_BR = cross_section(n2c,'x',x_max_B);
            y_max_BL = max(n2c(nodes_S.edge_BL,2));
            y_max_BR = max(n2c(nodes_S.edge_BR,2));
            nodes_S.corner_BLI = node_single(n2c,[x_min_B y_max_BL]);
            nodes_S.corner_BRI = node_single(n2c,[x_max_B y_max_BR]);
            nodes_T = cross_section(n2c,'y',y_max);
            x_min_T = min(n2c(nodes_T,1));
            x_max_T = max(n2c(nodes_T,1));
            nodes_S.corner_TL = node_single(n2c,[x_min_T y_max]);
            nodes_S.corner_TR = node_single(n2c,[x_max_T y_max]);
            nodes_S.corner_L = cross_section(n2c,'x',x_min);
            nodes_S.corner_R = cross_section(n2c,'x',x_max);
            nodes_S.corners = unique([nodes_S.corner_TO; nodes_S.corner_BLO; nodes_S.corner_BRO; nodes_S.corner_TL; nodes_S.corner_L; ...
                                      nodes_S.corner_TI; nodes_S.corner_BLI; nodes_S.corner_BRI; nodes_S.corner_TR; nodes_S.corner_R]);
            nodes_S.edges = unique([nodes_S.edge_C; nodes_S.edge_BL; nodes_S.edge_BR]);
        otherwise
%             fprintf('Wrong name of mesh geometry\n');
    end
else % dim==3
    
end

if dim==2
    [ed2n,ed2e,~,~] = getEdges(e2n);
    nodes_S.boundary = unique(ed2n(ed2e(:,2)==0,:));
else % dim==3
    [f2n,f2e,~,~] = getFaces(e2n);
    nodes_S.boundary = unique( f2n( f2e(:,2)==0,:));
end

end
