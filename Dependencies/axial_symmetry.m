function n2c_new = axial_symmetry(n2c_old,dims,c)
    if nargin==2
        c = 0;
    end
    n2c_new = n2c_old;
    for i=1:length(dims)
        d = convert(dims(i));
        n2c_new(:,d) = -(n2c_old(:,d)-c(i)) +c(i);  % 2*c(i) - n2c_old(:,dim)
    end
end