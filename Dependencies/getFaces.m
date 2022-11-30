function [faces2nodes, faces2elems, elems2faces, nodes2faces]=getFaces(elems2nodes)

%function: [element2faces, face2nodes]=get_faces(elems2nodes)
%requires: deleterepeatedrows
%generates faces of (tetrahedral 3D) triangulation defined in elems2nodes
%elems2nodes is matrix, whose rows contain numbers of its element nodes 
%face2edges returns faces numbers of each tetrahedral element
%face2nodes returns three node numbers of each face
%example: [element2faces, face2nodes]=...
%get_faces([1 3 4 5; 7 4 3 5; 5 7 6 4; 6 8 7 4; 2 1 4 5; 2 4 6 5])

if size(elems2nodes,2)==3  % edges of 2D triangle elements
    [faces2nodes,faces2elems,elems2faces,nodes2faces] = getEdges(elems2nodes);
    return
end

%extracts sets of faces
faces1=elems2nodes(:,[1 2 3]);
faces2=elems2nodes(:,[1 2 4]);
faces3=elems2nodes(:,[1 3 4]);
faces4=elems2nodes(:,[2 3 4]);

%as sets of their nodes (vertices)
vertices=zeros(size(elems2nodes,1)*4,3);
vertices(1:4:end,:)=faces1;
vertices(2:4:end,:)=faces2;
vertices(3:4:end,:)=faces3;
vertices(4:4:end,:)=faces4;

%repeated sets of nodes (joint faces) are eliminated 
[faces2nodes,elems2faces] = deleterepeatedrows(vertices);
elems2faces = reshape(elems2faces,size(elems2nodes,2),size(elems2nodes,1))';

%add on
faces2elems=entryInWhichRows(elems2faces); 
if (size(faces2elems,2)==1)
    faces2elems=[faces2elems 0*faces2elems];    %all faces are boundary faces!!!
end 
nodes2faces=entryInWhichRows(faces2nodes); 
