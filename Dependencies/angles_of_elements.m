function angles = angles_of_elements(n2c,e2n)

dim = size(n2c,2);

if dim==2  % 2D
    a = vecnorm((n2c(e2n(:,2),:) - n2c(e2n(:,1),:))')';
    b = vecnorm((n2c(e2n(:,3),:) - n2c(e2n(:,2),:))')';
    c = vecnorm((n2c(e2n(:,1),:) - n2c(e2n(:,3),:))')';

    alphas = acos((b.^2 +c.^2 -a.^2)./(2*b.*c));
    bettas = acos((a.^2 +c.^2 -b.^2)./(2*a.*c));
    gammas = acos((a.^2 +b.^2 -c.^2)./(2*a.*b));

    angles = [alphas bettas gammas];
    angles = (180/pi)*angles;
else       % 3D
    ne = size(e2n,1);
%     angles_0 = zeros(size(e2n));
    angles_1 = zeros(size(e2n));
%     angles_2 = zeros(size(e2n));
%     angles_3 = zeros(size(e2n));
    for k=1:ne
        for i=1:4
            switch i
                case 1
                    i_1 = e2n(k,1);  i_2 = e2n(k,2);  i_3 = e2n(k,3);  i_4 = e2n(k,4);
                case 2
                    i_1 = e2n(k,2);  i_2 = e2n(k,1);  i_3 = e2n(k,3);  i_4 = e2n(k,4);
                case 3
                    i_1 = e2n(k,3);  i_2 = e2n(k,1);  i_3 = e2n(k,2);  i_4 = e2n(k,4);
                case 4
                    i_1 = e2n(k,4);  i_2 = e2n(k,1);  i_3 = e2n(k,2);  i_4 = e2n(k,3);
            end
%             v1 = n2c(i_2,:) - n2c(i_1,:);
%             v2 = n2c(i_3,:) - n2c(i_1,:);
%             v3 = n2c(i_4,:) - n2c(i_1,:);
%             v12 = cross(v1,v2);  v21 = cross(v2,v1);
%             v13 = cross(v1,v3);  v31 = cross(v3,v1);
%             v23 = cross(v2,v3);  v32 = cross(v3,v2);
            a = norm(n2c(i_2,:)-n2c(i_1,:));
            b = norm(n2c(i_3,:)-n2c(i_1,:));
            c = norm(n2c(i_4,:)-n2c(i_1,:));
            d = norm(n2c(i_3,:)-n2c(i_2,:));
            e = norm(n2c(i_4,:)-n2c(i_2,:));
            f = norm(n2c(i_4,:)-n2c(i_3,:));
            alpha = acos((a.^2 +b.^2 -d.^2)./(2*a.*b));
            betta = acos((a.^2 +c.^2 -e.^2)./(2*a.*c));
            gamma = acos((b.^2 +c.^2 -f.^2)./(2*b.*c));
%             angles_0(k,i) = acos(dot(v12,v13)/(norm(v12)*norm(v13))) + ...
%                             acos(dot(v21,v23)/(norm(v21)*norm(v23))) + ...
%                             acos(dot(v31,v32)/(norm(v31)*norm(v32))) -pi;
            angles_1(k,i) = acos((cos(alpha)-cos(betta)*cos(gamma))/(sin(betta)*sin(gamma))) - ...
                            asin((cos(betta)-cos(alpha)*cos(gamma))/(sin(alpha)*sin(gamma))) - ...
                            asin((cos(gamma)-cos(alpha)*cos(betta))/(sin(alpha)*sin(betta)));
%             angles_2(k,i) = pi/2 - asin((cos(alpha)-cos(betta)*cos(gamma))/(sin(betta)*sin(gamma))) - ...
%                                    asin((cos(betta)-cos(alpha)*cos(gamma))/(sin(alpha)*sin(gamma))) - ...
%                                    asin((cos(gamma)-cos(alpha)*cos(betta))/(sin(alpha)*sin(betta)));
%             angles_3(k,i) = -pi + acos((cos(alpha)-cos(betta)*cos(gamma))/(sin(betta)*sin(gamma))) + ...
%                                   acos((cos(betta)-cos(alpha)*cos(gamma))/(sin(alpha)*sin(gamma))) + ...
%                                   acos((cos(gamma)-cos(alpha)*cos(betta))/(sin(alpha)*sin(betta)));            
        end
    end

    angles = angles_1;
%     angles = (180/pi)^2*angles;
    angles = (180/pi)*angles;
end

end
