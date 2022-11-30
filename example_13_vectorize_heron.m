n1=elements(:,1); n2=elements(:,2); n3=elements(:,3);

ver1 = coordinates(n1,:); 
ver2 = coordinates(n2,:); 
ver3 = coordinates(n3,:);

a = ver2-ver1; b = ver3-ver1; c = ver2-ver3;

a = sqrt(a(:,1).^2+a(:,2).^2);
b = sqrt(b(:,1).^2+b(:,2).^2);
c = sqrt(c(:,1).^2+c(:,2).^2);

s = (a+b+c)/2;
plocha = sum(sqrt(s.*(s-a).*(s-b).*(s-c)));
fprintf("Plocha pomocí vektorizace a Heronova v: %f\n", plocha)
