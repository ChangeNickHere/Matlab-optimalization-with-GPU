function C_MI = CellAtMatrixOfIndices(C,MI)
%input: cell C, matrix of indices MI
%output: cell C_MI
%example: 
%M=[1 2; 3 4; 5 6]; CI={[1;2;3];2;[3;3]}; 
%[M_CI,C_M]=MatrixRowsAtCellOfIndices(M,CI)

C_MI = cell(size(C,1),size(C,2));
for i=1:size(C,1)
    for j=1:size(C,2)     
        C_MI{i,j} = C{i,j}(MI);
    end
end

