function [n2c_final,e2n_final] = Union(n2c_1,e2n_1,n2c_2,e2n_2,nodes_duplicate_2,sym)  % Joining Two Domains Which Share Some Particular Nodes
% !!! EVERY DUPLICATING NODE MUST HAVE A UNIQUE ORIGINAL ONE WITH THE SAME COORDINATES. THE VICE-VERSA CONDITION IS NOT CHECKED !!!
% (there might be more original nodes on the connecting wall for which none of the duplicating nodes has the same coordinates)
if nargin<6
    sym = 0;
end

tol = 1e-12;
% tol_2 = tol/100;
% n2c_1 = round(n2c_1/tol_2)*tol_2;
% n2c_2 = round(n2c_2/tol_2)*tol_2;
n2c_1 = round(n2c_1,14);
n2c_2 = round(n2c_2,14);

% nodes_duplicate_1 = nodes_duplicate_2;
% for i=1:length(nodes_duplicate_2)
%     [~,nodes_duplicate_1(i)] = min(vecnorm(n2c_1-n2c_2(nodes_duplicate_2(i),:),2,2));
% end

nn_IS = numel(nodes_duplicate_2);    % numbers in intersection
nn_1 = size(n2c_1,1);
nn_2 = size(n2c_2,1);
nn = nn_1 +nn_2 -nn_IS;                % numbers in union

% testing
if sym
    nodes_duplicate_1 = nodes_duplicate_2;
else
    n2c_UN = [n2c_1; n2c_2]; 
    [n2c_UN_sort,I] = sortrows(n2c_UN);
    norms = vecnorm(diff(n2c_UN_sort),2,2);
    indx = find(norms<=tol);
    indx_2 = reshape([indx indx+1]',2*nn_IS,1);
    indx_3 = I(indx_2);
    [~,indx_4] = ismember(nodes_duplicate_2+nn_1,I(indx+1));
    nodes_duplicate_1_no_order = indx_3(indx_3<=nn_1);
    nodes_duplicate_1 = nodes_duplicate_1_no_order(indx_4);
end

nodes_duplicate_2_complement = setdiff(1:nn_2,nodes_duplicate_2)';
nodes_duplicate_2_complement_reorder = (nn_1+1:nn)';

n2c_final = [n2c_1; n2c_2(nodes_duplicate_2_complement,:)];

%  nodes_duplicate_2 -> nodes_duplicate_1
%  nodes_duplicate_2_complement -> (nn_1+1:nn)'
nodes_2 = [nodes_duplicate_2; nodes_duplicate_2_complement];
nodes_2_reorder = [nodes_duplicate_1; nodes_duplicate_2_complement_reorder];

% a trick by Andrei Bobrov - thank you 
% https://www.mathworks.com/matlabcentral/answers/441922-replace-elements-of-a-matrix
[lo,ii] = ismember(e2n_2,nodes_2);
e2n_2_reorder = e2n_2;
e2n_2_reorder(lo) = nodes_2_reorder(ii(lo));
e2n_final = [e2n_1; e2n_2_reorder];

end
