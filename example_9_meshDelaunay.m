% example_9_meshDelaunay.m
fprintf("example_9_meshDelaunay started.\n")
% commented because start_examples will provide data
% n=20; % Pocet uzlu
% % Funkce, ktera definuje hranici oblasti
% fx = @(x)2*(cos(x).*(1 + sin(x))); fy = @(y)sin(y);
% T = (linspace(0, n-1, n)*(2*pi/n));
% x = fx(T); y = fy(T);
DT = delaunayTriangulation(reshape(x,n_2D,1),reshape(y,n_2D,1));
triplot(DT);
fprintf("example_9_meshDelaunay completed.\n")