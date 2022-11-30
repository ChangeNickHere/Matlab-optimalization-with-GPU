function entryrows=entryInWhichRows(A)
%function: entryrows=entryInWhichRows(A)
%requires: none
%for every entry of integer matrix A, 
%its rows indices are stored in output matrix,
%zeros entries indicate no more occurence
%example: entryrows=entryInWhichRows([1 2; 1 3; 2 2]) returns
%         entryrows=[1   2   0; 
%                    1   3   3; 
%                    2   0   0]   
%meaning: entry 1 appears in rows 1 and 2
%         entry 2 appears in rows 1 and 3 (twice)
%         entry 3 appears in row  2 only

%repetitions
r=max(max(A));
repetitions=accumarray(A(:),1);
c=max(repetitions);

%column indices J
J=mcolon(ones(size(repetitions))',repetitions'); J=J';

%row indices I, number of rows K
AA=A'; AA=AA(:); 
[I,K]=sort(AA); 
K=ceil(K/size(A,2));

%linear indices
ind = sub2ind([r,c],I,J);

%write in the output matrix
entryrows=zeros(r,c);
entryrows(ind)=K;