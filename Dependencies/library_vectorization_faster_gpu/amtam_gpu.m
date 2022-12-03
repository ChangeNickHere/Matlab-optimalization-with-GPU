function amb = amtam_gpu(amx,ama)
% ama: ama(1:nx,1:ny,1:nz)
% amx: amx(1:nx,1:nk,1:nz)
% amb: amb(1:nk,1:ny,1:nz)

[~,ny,~] = size(ama);
[~,nk,nz] = size(amx);

amb     = zeros(nk,ny,nz, 'gpuArray');
for row = 1:nk
    avb = ama .* amx(:,row,:);
    amb(row,:,:) = sum(avb,1);   
    
    %old 
    %amb(row,:,:) = avtam(amx(:,row,:),ama);
end

return


