n1=elements(:,1); n2=elements(:,2); n3=elements(:,3);

ver1 = coordinates(n1,:); 
ver2 = coordinates(n2,:); 
ver3 = coordinates(n3,:);

xy = ones(3,3,ne);
xy(1,:,:) = [ver1(:,1),ver1(:,2), ones(ne,1)]';
xy(2,:,:) = [ver2(:,1),ver2(:,2), ones(ne,1)]';
xy(3,:,:) = [ver3(:,1),ver3(:,2), ones(ne,1)]';

plocha = sum(xy(1,1,:).*xy(2,2,:).*xy(3,3,:)+xy(1,2,:).*xy(2,3,:).*xy(3,1,:)+xy(1,3,:).*xy(2,1,:).*xy(3,2,:)...
        -xy(3,1,:).*xy(2,2,:).*xy(1,3,:)-xy(3,2,:).*xy(2,3,:).*xy(1,1,:)-xy(3,3,:).*xy(2,1,:).*xy(1,2,:))/2;
fprintf("Plocha pomocí vektorizace a determinantu 3x3: %f \n", plocha)
