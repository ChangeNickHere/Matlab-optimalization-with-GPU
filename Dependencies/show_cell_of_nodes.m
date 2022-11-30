function show_cell_of_nodes(n2c,nodes2display,MS,LW)
    dim = size(n2c,2);
    hold on
    for i=1:length(nodes2display.nodes)
        if dim==2
            plot (n2c(nodes2display.nodes{i},1),n2c(nodes2display.nodes{i},2),                               nodes2display.color{i}, 'MarkerSize',MS,'Linewidth',LW);
        else % dim==3
            plot3(n2c(nodes2display.nodes{i},1),n2c(nodes2display.nodes{i},2),n2c(nodes2display.nodes{i},3), nodes2display.color{i}, 'MarkerSize',MS,'Linewidth',LW);
        end
    end
    hold off
end