% meshGenerator.m
function [coordinates, elements, dirichlets] = meshGenerator(x,y)
    model = createpde; n = length(x);
    geometryDescription = [2, n, x, y]'; % Popis obrazce body hranice
    sf = 'object'; ns = char('object'); ns = ns';
    geometry = decsg(geometryDescription, sf, ns);
    geometryFromEdges(model,geometry);
    P = [x; y]'; [minDist,maxDist]=minAndMaxDist(P);
    mesh = generateMesh(model,'Hmax',maxDist, 'Hmin',minDist);
    figure;
    pdemesh(mesh)
    elements = mesh.Elements(1:3,:)'; % ulozeni elementu z mesh
    coordinates = mesh.Nodes'; 
    dirichlets = convhull(coordinates);
    dirichlets = intersect(dirichlets,elements);
end