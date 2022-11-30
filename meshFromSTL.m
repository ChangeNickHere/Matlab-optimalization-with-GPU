% meshFromSTL.m
%% Vraci pole coordinates a elements ziskane z STL modelu
function [coordinates, elements] = meshFromSTL(name)
    model = createpde;
    importGeometry(model, name);
    mesh = generateMesh(model);
    pdemesh(mesh)
    elements = mesh.Elements(1:4,:)'; 
    coordinates = mesh.Nodes';
end