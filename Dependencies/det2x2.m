plocha = 0;
for i = 1:size(elements,1)
    n1=elements(i,1); n2=elements(i,2); n3=elements(i,3);
    ver1 = coordinates(n1,:);    ver2 = coordinates(n2,:);
    ver3 = coordinates(n3,:);
    u = ver2-ver1; v = ver3-ver1;
    plocha = plocha + (det([u;v])/2);
end