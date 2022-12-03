function orientations = orientations_of_elements(n2c,e2n)

dim = size(n2c,2);

v1 = n2c(e2n(:,2),:) - n2c(e2n(:,1),:);
v2 = n2c(e2n(:,3),:) - n2c(e2n(:,2),:);

if dim==2  % triangles
    orientations = sign(v1(:,1).*v2(:,2)-v1(:,2).*v2(:,1));
else       % tetrahedras
    v12 = cross(v1,v2);
    v3 = n2c(e2n(:,4),:) - n2c(e2n(:,3),:);
    orientations = sign(dot(v3',v12'))';
end

end