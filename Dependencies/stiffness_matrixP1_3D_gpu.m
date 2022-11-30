%% Optimized for max speed (take a lot GPU memory)
function [K,volumes]=stiffness_matrixP1_3D_gpu(elements,coordinates,coeffs)
%coeffs can be either P0 (elementwise constant) or P1 (elementwise nodal) function 
%represented by a collumn vector with size(elements,1) or size(coordinates,1) entries
%if coeffs is not provided then coeffs=1 is assumed globally)

elements = gpuArray(elements);
coordinates = gpuArray(coordinates);

NE=size(elements,1); %number of elements
DIM=size(coordinates,2); %problem dimension

%particular part for a given element in a given dimension
NLB=4; %number of local basic functions, it must be known!  
coord=zeros(DIM,NLB,NE, 'gpuArray');
for d=1:DIM
    for i=1:NLB           
        coord(d,i,:)=coordinates(elements(:,i),d);       
    end   
end
IP=gpuArray([1/4 1/4 1/4]');    
[dphi,jac] = phider_gpu(coord,IP,'P1'); %integration rule, it must be known!  

volumes=abs(squeeze(jac))/factorial(DIM);

dphi = squeeze(dphi); 

if (nargin<3)
    Z=astam(volumes',amtam_gpu(dphi,dphi));  
else
    if numel(coeffs)==size(coordinates,1)  %P1->P0 averaging
        coeffs=evaluate_average_point(elements,coeffs);
    end  
    Z=astam((volumes.*coeffs)',amtam_gpu(dphi,dphi));
end

Y=reshape(repmat(elements,1,NLB)',NLB,NLB,NE);
X=permute(Y,gpuArray([2 1 3]));
K=sparse(X(:),Y(:),Z(:)); 


