function [logic_vector_D, logic_vector_N] = logic_vectors_3D(n2c,BC)

nbfn = BC.nbfn;
nn = size(n2c,1);
logic_vector_D = false(nbfn*nn,1);
logic_vector_N = false(nbfn*nn,1);

if nargin==2
    if isfield(BC,'Dirichlet')
        for i=1:length(BC.Dirichlet)
            logic_vector_D = update_logic_vector(logic_vector_D,BC.Dirichlet{i});
        end
    end
    if isfield(BC,'Neumann')
        for i=1:length(BC.Neumann)
            BC.Neumann{i}.directions = 1:nbfn;
            logic_vector_N = update_logic_vector(logic_vector_N,BC.Neumann{i});
        end
    end
end

function logic_vector_new = update_logic_vector(logic_vector_old,params)
    logic_vector = false(nbfn*nn,1);
    switch params.method
        case 'line'
            d_1 = convert(params.line(1));  d_2 = convert(params.line(2));
            nodes = n2c(:,d_1)>=params.coord(1)-params.tol & n2c(:,d_1)<=params.coord(1)+params.tol & ...
                    n2c(:,d_2)>=params.coord(2)-params.tol & n2c(:,d_2)<=params.coord(2)+params.tol;
        case 'plane'
            plane = convert(params.plane);
            nodes = n2c(:,plane)>=params.coord-params.tol & n2c(:,plane)<=params.coord+params.tol;
        case 'interval'
            xa=params.interval(1,1);  yc=params.interval(2,1);  ze=params.interval(3,1);
            xb=params.interval(1,2);  yd=params.interval(2,2);  zf=params.interval(3,2);
            nodes = n2c(:,1)>=xa-params.tol & n2c(:,1)<=xb+params.tol & n2c(:,2)>=yc-params.tol & ...
                    n2c(:,2)<=yd+params.tol & n2c(:,3)<=ze+params.tol & n2c(:,3)>=zf-params.tol;
        case 'single_node'
            x=params.coord(1); y=params.coord(2); z=params.coord(3);
            nodes = n2c(:,1)>=x-params.tol & n2c(:,1)<=x+params.tol & n2c(:,2)>=y-params.tol & ...
                    n2c(:,2)<=y+params.tol & n2c(:,3)<=z+params.tol & n2c(:,3)>=z-params.tol;
        case 'arc'
            if ~isfield(params,'a')  a = 1;  else  a = params.a;  end
            if ~isfield(params,'b')  b = 1;  else  b = params.b;  end
            if ~isfield(params,'c')  c = 1;  else  c = params.c;  end
            if ~isfield(params,'center')
                xc = 0; yc = 0; zc = 0;
            else
                xc = params.center(1); yc = params.center(2); zc = params.center(3);
            end
            [alpha,betta] = angles_3D(n2c,params.center);
            nodes = sqrt(((n2c(:,1)-xc)/a).^2+((n2c(:,2)-yc)/b).^2+((n2c(:,3)-zc)/c).^2) >= params.r-params.tol & ...
                    sqrt(((n2c(:,1)-xc)/a).^2+((n2c(:,2)-yc)/b).^2+((n2c(:,3)-zc)/c).^2) <= params.r+params.tol & ...
                    alpha >= params.alpha_int(1)-params.tol & alpha <= params.alpha_int(2)+params.tol & ...
                    betta >= params.betta_int(1)-params.tol & betta <= params.betta_int(2)+params.tol;
        otherwise
            error(join(['bad method :  ' params.method]));
    end
    for j=1:numel(params.directions)
        logic_vector(params.directions(j):nbfn:end) = nodes;
    end
    logic_vector_new = logic_vector_old | logic_vector;
end

end
