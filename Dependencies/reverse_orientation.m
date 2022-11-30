function e2n = reverse_orientation(e2n)
    e2n(:,1:3) = [e2n(:,1) e2n(:,3) e2n(:,2)];
end