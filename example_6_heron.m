%heron.m
plocha = 0;
for i = 1:size(elements,1)
    n1=elements(i,1); 
    n2=elements(i,2); 
    n3=elements(i,3);
    ver1 = coordinates(n1,:);    
    ver2 = coordinates(n2,:);
    ver3 = coordinates(n3,:);
    vecA = ver2-ver1;  vecB = ver3-ver1; vecC = ver2-ver3;
    a = norm(vecA); b = norm(vecB); c = norm(vecC);
    s = (a+b+c)/2;
    %Heronuv vzorec
    plocha = plocha + sqrt(s.*(s-a).*(s-b).*(s-c));
end
fprintf("Area calculated using Heron's formula. Area = %f\n",plocha)
