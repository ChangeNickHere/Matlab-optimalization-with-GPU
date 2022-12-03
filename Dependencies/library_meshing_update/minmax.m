function [minValues,maxValues] = minmax(A,cols)
% find the minimal and maximal collums values in a cell or in a matrix
% examples:
% A{1}=[1 2; 3 4]; A{2}=[-1 2; 5 6; 3 -2]; [minV,maxV] = minmax(A)
% B=[-1 2; 5 6; 3 -2]; [minV,maxV] = minmax(B)


if iscell(A)
    A=reshape(A,numel(A),1);
    A=cell2mat(A);              %A is now a matrix
end    

if ismatrix(A)
    minValues=min(A,[],1); 
    maxValues=max(A,[],1);
end
    
if nargin==2
    minValues=minValues(cols); maxValues=maxValues(cols);
end
end

