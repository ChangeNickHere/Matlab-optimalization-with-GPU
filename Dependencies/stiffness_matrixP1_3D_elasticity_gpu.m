function [K,areas]=stiffness_matrixP1_3D_elasticity_gpu(elements,coordinates,lambda,mu)

% transfer to GPU array 
elements = gpuArray(elements);
coordinates = gpuArray(coordinates);

%for laplace
NE=size(elements,1); %number of elements
DIM=size(coordinates,2); %problem dimension
 
%laplace 
NLB=4; %number of local basic functions, it must be known!
coord=zeros(DIM,NLB,NE, 'gpuArray');
for d=1:DIM
     for i=1:NLB
         coord(d,i,:)=coordinates(elements(:,i),d);
     end
end   
clear coordinates

IP=gpuArray([1/4 1/4 1/4]');    
[dphi,jac] = phider_gpu(coord,IP,'P1'); %integration rule, it must be known!  
clear coord 

areas=abs(squeeze(jac))/factorial(DIM);
clear jac

%elasticity matrix is derived from laplace matrix, see paper 
%Matlab implementation of the FEM in Elasticity by 
%Alberty, Carstensen, Funken, Klose
R=zeros(6,12,NE, 'gpuArray');
R([1,4,5],1:3:10,:)=dphi;  
R([4,2,6],2:3:11,:)=dphi;
R([5,6,3],3:3:12,:)=dphi;
clear dphi

C=mu*gpuArray(diag([2 2 2 1 1 1])) + lambda*gpuArray(kron([1 0; 0 0],ones(3)));

Elements=3*elements(:,gpuArray(kron(1:4,[1 1 1])))...
         -gpuArray(kron(ones(NE,1),gpuArray(kron([1 1 1 1],[2 1 0]))));
clear elements

Z=astam(areas',amtam_gpu(R,smamt_gpu(C,permute(R,gpuArray([2 1 3])))));
clear R
clear areas

Y=reshape(repmat(Elements,1,12)',12,12,NE);
X=permute(Y,gpuArray([2 1 3]));

K=sparse(X(:),Y(:),Z(:));


