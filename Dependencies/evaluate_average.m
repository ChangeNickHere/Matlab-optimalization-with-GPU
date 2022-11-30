function average = evaluate_average(u,I,w)
% u - column vector or matrix of values
% I - matrix of indices, averages are computed over rows
% w - weights (optional)

    if nargin<3  % no weights
        w = (1/size(I,2))*ones(1,size(I,2));
    end
     
    average = w(:,1).*u(I(:,1),:);
    for j=2:size(I,2)
        average = average + w(:,j).*u(I(:,j),:);
    end
%    average = sum(u(I).*w,2);  % only if 'u' is a vector
end