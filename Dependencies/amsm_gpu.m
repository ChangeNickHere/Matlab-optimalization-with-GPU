function amb = amsm_gpu(ama,smx)
% ama: ama(1:nx,1:ny,1:nz)
% smx: smx(1:ny,1:nk)
% amb: amb(1:nx,1:nk,1:nz)

[nx,~,nz] = size(ama);
[~,nk]    = size(smx);

amb     = zeros(nx,nk,nz, 'gpuArray');
for col = 1:nk

    amb(:,col,:) = amsv(ama,smx(:,col));
    
end

return