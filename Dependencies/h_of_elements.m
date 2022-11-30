function [h_min,h_max] = h_of_elements(n2c,e2n)

dim = size(n2c,2);
ne = size(e2n,1);

edges_sizes = zeros(ne,factorial(dim));
edges_sizes(:,1) = vecnorm(n2c(e2n(:,2),:)-n2c(e2n(:,1),:),2,2);
edges_sizes(:,2) = vecnorm(n2c(e2n(:,3),:)-n2c(e2n(:,1),:),2,2);
edges_sizes(:,3) = vecnorm(n2c(e2n(:,3),:)-n2c(e2n(:,2),:),2,2);
if dim==3
    edges_sizes(:,4) = vecnorm(n2c(e2n(:,4),:)-n2c(e2n(:,1),:),2,2);
    edges_sizes(:,5) = vecnorm(n2c(e2n(:,4),:)-n2c(e2n(:,2),:),2,2);
    edges_sizes(:,6) = vecnorm(n2c(e2n(:,4),:)-n2c(e2n(:,3),:),2,2);
end

h_min = min(min(edges_sizes));
h_max = max(max(edges_sizes));

end