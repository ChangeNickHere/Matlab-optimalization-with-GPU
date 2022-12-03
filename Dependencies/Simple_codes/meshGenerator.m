function [coordinates, elements, dirichlet] = meshGenerator(x,y,minEdgeLength, maxEdgeLength)
%   MESHGENERATOR Summary of this function goes here
%
%   Input parameters:   
%   First parameter is array of x coordinates on boundary
%   Second parameter is array of y coordinates on boundary
%   Third parameter is minimum length of mesh generation triangles edge
%   Forth parameter is maximum length of mesh generation triangles edge
%   The number in last two parameters must be positive, if you dont wanna
%   use one or both of the parameters enter 0
%
%   Output parameters:
%   First parameter is nx2 array of coordinates (points genereted via
%   meshing). First column is x coordinates and second is y.

%   Second parameter is nx3 array of elements (indexes of coordinates).
%   Each column is index of triangles one point from coordinates.
%
%   Third parametes is nx1 array of dirichlet nodes (indexes of
%   coordinates). Each index cooresponds to one poin on boundary when given to coordinates.

model = createpde;
len = length(x);
geometryDescription = [2, len, x, y]';

sf = 'object';

ns = char('object');
ns = ns';
geometry = decsg(geometryDescription, sf, ns);

geometryFromEdges(model,geometry);

switch nargin
    case 2
        P = [x; y]';
        [minDist,maxDist]=bruteForce(P);
        mesh = generateMesh(model,'Hmax',maxDist, 'Hmin',minDist);

    case 3
        mesh = generateMesh(model,'Hmin',minEdgeLength);
    
    case 4
        mesh = generateMesh(model,'Hmax',maxEdgeLength, 'Hmin',minEdgeLength);
       
    otherwise
        if minEdgeLength == 0 && maxEdgeLength > 0
            mesh = generateMesh(model,'Hmax',maxEdgeLength);
        elseif minEdgeLength > 0 && maxEdgeLength == 0
            mesh = generateMesh(model,'Hmin',minEdgeLength);
        elseif minEdgeLength > 0 && maxEdgeLength > 0
            mesh = generateMesh(model,'Hmax',maxEdgeLength, 'Hmin',minEdgeLength);
        end
end

% figure
% pdemesh(mesh)
% axis equal

elements = mesh.Elements(1:3,:)'; 
coordinates = mesh.Nodes';

dirichlet = convhull(coordinates);
dirichlet = intersect(dirichlet,elements);
end

function [minDist, maxDist] = bruteForce(points)
        minDist = intmax;
        maxDist = 0;
        for i = 1 : length(points)
           A = points(i, :);
           for j = i+1 : length(points)
              B = points(j, :);
              dist = norm(A-B);%sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2);
              if minDist > dist
                  minDist = dist;
              end
              if maxDist < dist
                  maxDist = dist;
              end
           end
        end
end

