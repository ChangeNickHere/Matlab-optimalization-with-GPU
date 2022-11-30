% minAndMaxDist.m

function [minDist, maxDist] = minAndMaxDist(points)
    minDist = intmax;
    maxDist = 0;
    for i = 1 : length(points)
       A = points(i, :);
       for j = i+1 : length(points)
          B = points(j, :);
          dist = norm(A-B);
          if minDist > dist
              minDist = dist;
          end
          if maxDist < dist
              maxDist = dist;
          end
       end
    end
end