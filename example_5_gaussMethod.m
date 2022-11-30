% example_5_gaussMethod.m

% commented because start_examples will provide data
% n = 10;
% fx = @(x)2*(cos(x).*(1+sin(x))); fy=@(y)sin(y);  % hranice
% t = (linspace(0,n-1,n)*(2*pi/n));
% x = fx(t); y = fy(t);                            % body hranice
S = sum(x.*(([y(2:end), y(1)]) - ([y(end), y(1:end-1)])))/2;
fprintf("Area calculated using Gauss method. Area = %f\n",S)
fprintf("example_5_gaussMethod completed.\n")