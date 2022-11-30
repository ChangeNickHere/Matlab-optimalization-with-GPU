%elements = [1,2,3;1,2,5;1,4,5];
%coordinates = [1 0; 1 1; 0 1; 2 0; 2 1];

sumTriangleHeron = 0;

for i = 1:size(elements,1)
    node1=elements(i,1);
    node2=elements(i,2);
    node3=elements(i,3);
    
    vertex1 = coordinates(node1,:);
    vertex2 = coordinates(node2,:);
    vertex3 = coordinates(node3,:);
    
    u = vertex2-vertex1;
    v = vertex3-vertex1;
    w = vertex2-vertex3;

    lenU = norm(u);
    lenV = norm(v);
    lenW = norm(w);
    s = (lenU+lenV+lenW)/2;

    %Heron's formula
    sumTriangleHeron = sumTriangleHeron + sqrt(s.*(s-lenU).*(s-lenV).*(s-lenW));
end




