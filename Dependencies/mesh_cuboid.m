function [n2c,e2n,nodes_S,nxyz] = mesh_cuboid(params)

%------------------------------------------------------------------
%  level ... level of refinement
%     lx ... x-length
%     ly ... y-length
%     lz ... z-length
%   xyz0 ... xyz-origin
%    nx0 ... number of x-segments for level 0
%    ny0 ... number of y-segments for level 0
%    nz0 ... number of z-segments for level 0
%     nx ... number of nodes for a single x-lane
%     ny ... number of nodes for a single y-lane
%     nz ... number of nodes for a single z-lane
%    qhx ... relative scale of x-step
%    qhy ... relative scale of y-step
%    qhz ... relative scale of z-step
%   diag ... choice of cutting an elementary cuboid (hx-hy-hz)
%                        (4 choices to connect opposite nodes)
%                       1: nodes 1-8  ( [0,0,0]---[hx,hy,hz] )
%                       2: nodes 2-7  ( [hx,0,0]---[0,hy,hz] )
%                       3: nodes 3-6  ( [0,hy,0]---[hx,0,hz] )
%                       4: nodes 4-5  ( [hx,hy,0]---[0,0,hz] )
%------------------------------------------------------------------
%  - all 'nx','ny','nz' can be specified in the input 'params'
%  - if one of 'nx','ny','nz' is specified, the rest are set
%    such that  nx:ny:nz ~ lx:ly:lz  (and therefore  hx ~ hy ~ hz)
%  - if two of 'nx','ny','nz' are specified (e.g. 'nx','ny'), the
%    remaining one (e.g. 'nz') is set such that  hz = (hx+hy)/2
%  - if none of 'nx','ny','nz' is specified, all are set such that
%                                      nx = round(nx0*2^level) +1;
%                                      ny = round(ny0*2^level) +1;
%                                      nz = round(nz0*2^level) +1;
%------------------------------------------------------------------

if nargin==0  params = [];  end
if ~isfield(params,  'lx')   lx = 1;  else   lx = params.  lx; end
if ~isfield(params,  'ly')   ly = 1;  else   ly = params.  ly; end
if ~isfield(params,  'lz')   lz = 1;  else   lz = params.  lz; end
if ~isfield(params, 'qhx')  qhx = 1;  else  qhx = params. qhx; end
if ~isfield(params, 'qhy')  qhy = 1;  else  qhy = params. qhy; end
if ~isfield(params, 'qhz')  qhz = 1;  else  qhz = params. qhz; end
if ~isfield(params,'xyz0') xyz0 = 0;  else xyz0 = params.xyz0; end
if ~isfield(params,'diag') diag = 3;  else diag = params.diag; end
if isfield(params,'nx') && isfield(params,'ny') && isfield(params,'nz')
    nx = params.nx;
    ny = params.ny;
    nz = params.nz;
elseif isfield(params,'nx') && ~isfield(params,'ny') && ~isfield(params,'nz')
    nx = params.nx;
    ny = round((ly/lx)*(nx-1)/qhy) +1;
    nz = round((lz/lx)*(nx-1)/qhz) +1;
elseif ~isfield(params,'nx') && isfield(params,'ny') && ~isfield(params,'nz')
    ny = params.ny;
    nx = round((lx/ly)*(ny-1)/qhx) +1;
    nz = round((lz/ly)*(ny-1)/qhz) +1;
elseif ~isfield(params,'nx') && ~isfield(params,'ny') && isfield(params,'nz')
    nz = params.nz;
    nx = round((lx/lz)*(nz-1)/qhx) +1;
    ny = round((ly/lz)*(nz-1)/qhy) +1;
elseif isfield(params,'nx') && isfield(params,'ny') && ~isfield(params,'nz')
    nx = params.nx;
    ny = params.ny;
    hx = lx/(nx-1);  hy = ly/(ny-1);  hz = (hx+hy)/2/qhz;
    nz = round(lz/hz) +1;
elseif isfield(params,'nx') && ~isfield(params,'ny') && isfield(params,'nz')
    nx = params.nx;
    nz = params.nz;
    hx = lx/(nx-1);  hz = lz/(nz-1);  hy = (hx+hz)/2/qhy;
    ny = round(ly/hy) +1;
elseif ~isfield(params,'nx') && isfield(params,'ny') && isfield(params,'nz')
    ny = params.ny;
    nz = params.nz;
    hy = ly/(ny-1);  hz = lz/(nz-1);  hx = (hy+hz)/2/qhx;
    nx = round(lx/hx) +1;
else  % automatically  ~isfield(params,'nx') && ~isfield(params,'ny') && ~isfield(params,'nz')
    if ~isfield(params,'level')
        level = 1;
    else
        level = params.level;
    end
    min_xyz = min([lx ly lz]);
    if ~isfield(params,'nx0')
        if lx == min_xyz
            nx0 = 1;
        elseif ly == min_xyz
            nx0 = lx/ly;
        else % lz == min_xyz
            nx0 = lx/lz;
        end
    else
        nx0 = params.nx0;
    end
    if ~isfield(params,'ny0')
        if ly == min_xyz
            ny0 = 1;
        elseif lx == min_xyz
            ny0 = ly/lx;
        else % lz == min_xyz
            ny0 = ly/lz;
        end
    else
        ny0 = params.ny0;
    end
    if ~isfield(params,'nz0')
        if lz == min_xyz
            nz0 = 1;
        elseif lx == min_xyz
            nz0 = lz/lx;
        else % ly == min_xyz
            nz0 = lz/ly;
        end
    else
        nz0 = params.nz0;
    end
    nx = round(nx0*2^level/qhx) +1;   % number of x-nodes
    ny = round(ny0*2^level/qhy) +1;   % number of y-nodes
    nz = round(nz0*2^level/qhz) +1;   % number of z-nodes
end
if nx<2 nx=2; end
if ny<2 ny=2; end
if nz<2 nz=2; end

%====================================================================================================================
nn = nx*ny*nz;                % total number of nodes
ne = 6*(nx-1)*(ny-1)*(nz-1);  % total number of elements
hx = lx/(nx-1);               % x-step
hy = ly/(ny-1);               % y-step
hz = lz/(nz-1);               % y-step
%====================================================================================================================
nxy = nx*ny;
x_section = 0:hx:lx;
y_section = 0:hy:ly;
z_section = 0:hz:lz;
n2c = [repmat(x_section',ny*nz,1) reshape(repmat(y_section,nx,nz),nn,1) reshape(repmat(z_section,nxy,1),nn,1)];
n2c = n2c +xyz0;
%====================================================================================================================
block_xyz = repmat( repmat(1:nx-1,1,ny-1) + reshape(repmat(0:nx:(ny-2)*nx,nx-1,1),1,(nx-1)*(ny-1)), 1, nz-1) + ...
           reshape( repmat(0:nxy:(nz-2)*nxy,(nx-1)*(ny-1),1), 1, (nx-1)*(ny-1)*(nz-1));
block_Xyz = block_xyz +1;
block_xYz = block_xyz +nx;
block_XYz = block_xyz +nx +1;
block_xyZ = block_xyz +nxy;
block_XyZ = block_xyz +nxy +1;
block_xYZ = block_xyz +nxy +nx;
block_XYZ = block_xyz +nxy +nx +1;
switch diag
    case 1
        N_1 = reshape(repmat(block_xyz,6,1),ne,1);
        N_2 = reshape([block_Xyz; block_XYz; block_xyZ; block_XyZ; block_xYz; block_xYZ],ne,1);
        N_3 = reshape([block_XYz; block_xYz; block_XyZ; block_Xyz; block_xYZ; block_xyZ],ne,1);
        N_4 = reshape(repmat(block_XYZ,6,1),ne,1);
    case 2
        N_1 = reshape(repmat(block_Xyz,6,1),ne,1);
        N_2 = reshape([block_xYz; block_XYz; block_xyz; block_xyZ; block_XYZ; block_XyZ],ne,1);
        N_3 = reshape([block_xyz; block_xYz; block_xyZ; block_XyZ; block_XYz; block_XYZ],ne,1);
        N_4 = reshape(repmat(block_xYZ,6,1),ne,1);
    case 3
        N_1 = reshape(repmat(block_xYz,6,1),ne,1);
        N_2 = reshape([block_xyz; block_Xyz; block_xyZ; block_xYZ; block_XYz; block_XYZ],ne,1);
        N_3 = reshape([block_Xyz; block_XYz; block_xyz; block_xyZ; block_XYZ; block_xYZ],ne,1);
        N_4 = reshape(repmat(block_XyZ,6,1),ne,1);
    case 4
        N_1 = reshape(repmat(block_XYz,6,1),ne,1);
        N_2 = reshape([block_xyz; block_xYz; block_Xyz; block_XyZ; block_xYZ; block_XYZ],ne,1);
        N_3 = reshape([block_Xyz; block_xyz; block_XyZ; block_XYZ; block_xYz; block_xYZ],ne,1);
        N_4 = reshape(repmat(block_xyZ,6,1),ne,1);
    otherwise
        error('Bad number of diagonal orientation : %d\n',diag);
end
e2n = [N_1 N_2 N_3 N_4];
%====================================================================================================================
nodes_S = [];
if nargout==3
    nodes_S = nodes_of_mesh(n2c,e2n,'cuboid',params);
end
%====================================================================================================================
if nargout==4
    nxyz = [nx ny nz];
end
%====================================================================================================================

if isfield(params,'print_mesh_info') && params.print_mesh_info
    fprintf('cuboid %d x %d x %d\n',nx-1,ny-1,nz-1);
    print_mesh_info(n2c,e2n);
end

end
