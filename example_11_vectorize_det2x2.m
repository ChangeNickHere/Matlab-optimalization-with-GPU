n1=elements(:,1); n2=elements(:,2); n3=elements(:,3);

ver1 = coordinates(n1,:); 
ver2 = coordinates(n2,:); 
ver3 = coordinates(n3,:);

a = ver2-ver1; b = ver3-ver1;

ne = size(elements,1); %number of elements
uv = zeros(2,2,ne);

uv(1,1,:) = a(:,1); %a
uv(1,2,:) = a(:,2); %b
uv(2,1,:) = b(:,1); %c
uv(2,2,:) = b(:,2); %d

a = uv(1,1,:); b = uv(1,2,:);
c = uv(2,1,:); d = uv(2,2,:);

plocha = sum(((a.*d)-(c.*b))/2);
fprintf("Plocha pomocí vektorizace a determinantu 2x2: %f \n", plocha)
