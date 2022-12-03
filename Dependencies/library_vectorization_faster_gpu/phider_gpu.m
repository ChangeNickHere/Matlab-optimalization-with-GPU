function [dphi,detj,jac] = phider_gpu (coord,point,etype)
% PHIDER Returns the gradients of the basis functions
%        with respect to the local coordinates (x,y,...).
%
% coord : coord(nod,nos,noe), the local coordinates of the
%         nodes which the shape functions are associated with.
% point : point(nod,nop), the coordinates of the
%         points on the reference element.
%  dphi : dphi(nod,nos,nop,noe), the gradients of the
%         shape functions (second) at all points (third)
%         with respect to the local cordinates.
%   jac : jac(nod,nod,nop,noe), the Jacobian matrices
%         at all nop points.
%  detj : detj(1,nop,noe), determinants of the Jacobian matrices
%         at all nop points
% etype : 'P0','P1','P2', etc., the element type.
%
%         Note:
%         nod - dimension of the element.
%         nop - number of points.
%         nos - number of shape functions.
%         noe - number of elements.

jacout = 'no';
if nargout >2, jacout = 'yes'; end
detout = 'no';
if nargout >1, detout = 'yes'; end
    
nod = size(coord,1);
nop = size(point,2);
nos = size(coord,2);
noe = size(coord,3);

% Derivatives with respect to the reference
% coordinates (xi,eta,...).
dshape = gpuArray(shapeder(point,etype));

if strcmp(jacout, 'yes'), jac  = zeros(nod,nod,nop,noe, 'gpuArray'); end
if strcmp(detout,'yes'),  detj = zeros(1,nop,noe, 'gpuArray'); end
dphi = zeros(nod,nos,nop,noe, 'gpuArray');

for poi = 1:nop
    
    tjac              = smamt_gpu(dshape(:,:,poi),coord);
    [tjacinv,tjacdet] = aminv_gpu(tjac);
    dphi(:,:,poi,:)   = amsm_gpu(tjacinv,dshape(:,:,poi));
    
    if strcmp(jacout, 'yes')
       jac(:,:,poi,:) = tjac;
    end
    if strcmp(detout, 'yes')
       detj(1,poi,:) = abs(tjacdet);
    end

end

return
