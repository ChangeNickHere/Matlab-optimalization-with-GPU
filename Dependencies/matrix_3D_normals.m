function vectors_3D = matrix_3D_normals(n2c,e2n,method)

if nargin<3
    method = 1;
end

dim = size(n2c,2);  % spatial dimension
ne = size(e2n,1);   % number of mesh elements

switch method
    case 1  % original (two nested loops)
        vectors_3D = zeros(dim,dim,ne);
        for d=1:dim
            for j=1:dim
                vectors_3D(d,j,:) = n2c(e2n(:,j),d) - n2c(e2n(:,dim+1),d);
            end
        end
    case 2  % preallocating (two nested loops)
        vectors_3D = zeros(dim,dim,ne);
        for d=1:dim
            n2c_last = n2c(e2n(:,dim+1),d);
            for j=1:dim
                vectors_3D(d,j,:) = n2c(e2n(:,j),d) - n2c_last;
            end
        end
    case 3  % preallocating (one loop)
        vectors_3D = zeros(dim,dim,ne);
        n2c_last = n2c(e2n(:,dim+1),:);
        for j=1:dim
            vectors_3D(:,j,:) = (n2c(e2n(:,j),:) - n2c_last)';
        end
    case 4  % vectorization
        n2c_last = n2c(e2n(:,dim+1),:);
        n2c_dim = n2c(reshape(e2n(:,1:end-1)',dim*ne,1),:);
        n2c_last_mult = reshape(repmat(n2c_last',dim,1),dim,dim*ne)';
        temp = n2c_dim - n2c_last_mult;
        vectors_3D = reshape(temp',dim,dim,ne);
    case 5  % vectorization and 'permute'
        n2c_last = n2c(e2n(:,dim+1),:);
        n2c_dim = n2c(reshape(e2n(:,1:end-1),dim*ne,1),:);
        n2c_last_mult = repmat(n2c_last,dim,1);
        temp = n2c_dim - n2c_last_mult;
        vectors_3D = reshape(temp',dim,ne,dim);
        vectors_3D = permute(vectors_3D,[1 3 2]);
    otherwise
        error('bad method: %d',method);
end

end
