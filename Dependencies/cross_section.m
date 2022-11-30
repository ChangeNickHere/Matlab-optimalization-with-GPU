function nodes = cross_section(n2c,dims,coords,tol)

if nargin<4
    tol = 1e-12;
    if nargin<3
        coords = zeros(length(dims),1);
    end
end

nn = size(n2c,1);
logic = true(nn,1);
for i=1:length(dims)
    d = convert(dims(i));
    coord = coords(i);
    logic = logic & n2c(:,d)>=coord-tol & n2c(:,d)<=coord+tol;
end

nodes = find(logic);

end