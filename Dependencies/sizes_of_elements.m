function sizes = sizes_of_elements(n2c,e2n)

dim = size(n2c,2);
vectors_3D = matrix_3D_normals(n2c,e2n,5);
sizes = abs(amdet(vectors_3D)/factorial(dim));

end