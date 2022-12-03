function nodes = nodes_interval(n2c,int,tol)

[nn,dim] = size(n2c);
if nargin<3
    tol = 1e-12;
end

for d=1:dim
    if int(d,1)>int(d,2)
        int(d,:) = [int(d,2) int(d,1)];
    end
end

logic = true(nn,1);
for d=1:dim
    logic = logic & (n2c(:,d)>=int(d,1)-tol & n2c(:,d)<=int(d,2)+tol);
end
nodes = find(logic);

end