% example_10_vectorization.m

fprintf("example_10_vectorization started.\n")
n1=elements(:,1); n2=elements(:,2); n3=elements(:,3);

ver1 = coordinates(n1,:); 
ver2 = coordinates(n2,:); 
ver3 = coordinates(n3,:);

u = ver2-ver1; v = ver3-ver1;

ne = size(elements,1); %number of elements
uv = zeros(2,2,ne);

uv(1,1,:) = u(:,1); %a
uv(1,2,:) = u(:,2); %b
uv(2,1,:) = v(:,1); %c
uv(2,2,:) = v(:,2); %d

a = uv(1,1,:); b = uv(1,2,:);
c = uv(2,1,:); d = uv(2,2,:);

matrix3D = [a, b; c, d];
fprintf("example_10_vectorization completed.\n")