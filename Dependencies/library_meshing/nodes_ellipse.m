function nodes = nodes_ellipse(n2c,r,center,a,b,tol)

if nargin<6
    tol = 1e-12;
    if nargin<5  % a = b  ==>  circle
        a = 1;
        b = 1;
    end
end

n2c = n2c - center;
n2c = [n2c(:,1)/a n2c(:,2)/b];
norms = vecnorm(n2c')';
nodes = find(norms>=r-tol & norms<=r+tol);

end
