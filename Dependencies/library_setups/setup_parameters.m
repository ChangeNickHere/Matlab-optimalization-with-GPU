%===VISUALIZE_PARAMETERS================================================================================
params.show.Dirichlet.Full = 1;     % show Dirichlet nodes fixed in all directions  (red color)
params.show.Dirichlet.Two = 0;      % show Dirichlet nodes fixed in two directions (cyan color)
params.show.Dirichlet.One = 0;      % show Dirichlet nodes fixed in one direction (green color)
                                    % for scalar problems Dirichlet nodes are always FullDirichlet
params.show.normals.arrows = 1;     % show normals
params.show.normals.vertices = 0;   % show normals' faces' vertices
params.show.normals.q = 0.15;       % length of arrows relative to mesh size
params.show.Dstyle{1} = 'ro';       %    full Dirichlet nodes color ('dim  ' fixed directions)
params.show.Dstyle{2} = 'co';       % partial Dirichlet nodes color ('dim-1' fixed directions)
params.show.Dstyle{3} = 'go';       % partial Dirichlet nodes color ('dim-2' fixed directions)
                                    % for scalar problems every node can have only one fixed direction
params.show.Nstyle{1} = 'go';       % normals' faces' vertices color
params.show.Nstyle{2} = 'k.';       % normals' faces' midpoints color
params.show.Nstyle{3} = 'k' ;       % arrows color
params.show.PS = 3.0;               % point size
params.show.LW = 4.0;               % point line width
%=======================================================================================================
