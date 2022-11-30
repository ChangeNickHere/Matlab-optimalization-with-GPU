function node = node_single(n2c,coord,tol)

if nargin<3
    tol = 1e-12;
end

if size(coord,2)>1
    coord = coord';
end

dim = size(n2c,2);
node = nodes_interval(n2c,[coord coord],tol);
if isempty(node)
    if dim==2
        error('None of the nodes is in [%.3f,%.3f]',coord(1),coord(2));
    else % dim==3
        error('None of the nodes is in [%.3f,%.3f,%.3f]',coord(1),coord(2),coord(3));
    end
elseif length(node)>1
    if dim==2
        error('More than one node is in [%.3f,%.3f]',coord(1),coord(2));
    else % dim==3
        error('More than one node is in [%.3f,%.3f,%.3f]',coord(1),coord(2),coord(3));
    end
end

end