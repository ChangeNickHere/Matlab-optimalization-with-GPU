function [n2c,e2n,nodes_C,nxyz] = mesh_cuboid_sym(params)

%------------------------------------------------------------------
%  level ... level of refinement
%     lx ... x-length
%     ly ... y-length
%     lz ... z-length
%   xyz0 ... xyz-origin  ([0 0 0] by default)
%  x_sym ... 'x' symmetry
%  y_sym ... 'y' symmetry  (only 'y' symmetry by default)
%  z_sym ... 'z' symmetry
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

if nargin==0 
    params = []; 
end
if ~isfield(params,'level')
    level = 0;
else
    level = params.level;
end
if ~isfield(params,'lx')
    lx = 1;
else
    lx = params.lx;
end
if ~isfield(params,'ly')
    ly = 1;
else
    ly = params.ly;
end
if ~isfield(params,'lz')
    lz = 1;
else
    lz = params.lz;
end
if ~isfield(params,'xyz0')
    xyz0 = [0 0 0];
else
    xyz0 = params.xyz0;
end
if ~isfield(params,'x_sym')
    x_sym = 0;
else
    x_sym = params.x_sym;
end
if ~isfield(params,'y_sym')
    y_sym = 1;
else
    y_sym = params.y_sym;
end
if ~isfield(params,'z_sym')
    z_sym = 0;
else
    z_sym = params.z_sym;
end
if ~isfield(params,'qhx')
    qhx = 1;
else
    qhx = params.qhx;
end
if ~isfield(params,'qhy')
    qhy = 1;
else
    qhy = params.qhy;
end
if ~isfield(params,'qhz')
    qhz = 1;
else
    qhz = params.qhz;
end
if ~isfield(params,'diag')
    diag = 3;
else
    diag = params.diag;
end

%============================================================================
cuboid_basis.level = level;
if x_sym
    cuboid_basis.lx = lx/2;
else
    cuboid_basis.lx = lx;
end
if y_sym
    cuboid_basis.ly = ly/2;
else
    cuboid_basis.ly = ly;
end
if z_sym
    cuboid_basis.lz = lz/2;
else
    cuboid_basis.lz = lz;
end
cuboid_basis.qhx = qhx;
cuboid_basis.qhy = qhy;
cuboid_basis.qhz = qhz;
cuboid_basis.diag = diag;
[n2c_temp,e2n_temp,~,nxyz_basis] = mesh_cuboid(cuboid_basis);
%=============================================================================
if x_sym
    n2c_sym = axial_symmetry(n2c_temp,'x',lx/2);
    e2n_sym = reverse_orientation(e2n_temp);
    nodes_x = cross_section(n2c_sym,'x',lx/2);
    [n2c_temp,e2n_temp] = Union(n2c_temp,e2n_temp,n2c_sym,e2n_sym,nodes_x);
end
if y_sym
    n2c_sym = axial_symmetry(n2c_temp,'y',ly/2);
    e2n_sym = reverse_orientation(e2n_temp);
    nodes_y = cross_section(n2c_sym,'y',ly/2);
    [n2c_temp,e2n_temp] = Union(n2c_temp,e2n_temp,n2c_sym,e2n_sym,nodes_y);
end
if z_sym
    n2c_sym = axial_symmetry(n2c_temp,'z',lz/2);
    e2n_sym = reverse_orientation(e2n_temp);
    nodes_z = cross_section(n2c_sym,'z',lz/2);
    [n2c_temp,e2n_temp] = Union(n2c_temp,e2n_temp,n2c_sym,e2n_sym,nodes_z);
end
%============================================================================
n2c = n2c_temp +xyz0;  e2n = e2n_temp;
%============================================================================
nodes_C = [];
if nargout==3
    nodes_C = nodes_of_mesh(n2c_temp,e2n_temp,'cuboid',params);
end
%============================================================================
if nargout==4
    nxyz = nxyz_basis;
    if x_sym
        nxyz(1) = 2*nxyz_basis(1) -1;
    end
    if y_sym
        nxyz(2) = 2*nxyz_basis(2) -1;
    end
    if z_sym
        nxyz(3) = 2*nxyz_basis(3) -1;
    end
end
%============================================================================

if isfield(params,'print_mesh_info') && params.print_mesh_info
    fprintf('cuboid_sym %d x %d x %d\n',nxyz(1)-1,nxyz(2)-1,nxyz(3)-1);
    print_mesh_info(n2c_temp,e2n_temp);
end

end
