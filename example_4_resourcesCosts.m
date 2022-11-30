% example_4_resourcesCosts.m
fprintf("example_4_resourcesCosts started.\n")
n = 100000000; % pocet prvku
X = linspace(1, 10, n);
t = tic;
Y = sin(X); 
tc = toc(t);
fprintf("Time CPU %f.\n",tc)
t = tic; 
X_GPU = gpuArray(X);
Y_GPU = sin(X_GPU);
tg = toc(t); % ziskani dat z GPU zpet na operacni pamet PC
fprintf("Time GPU %f.\n",tg)
fprintf("example_4_resourcesCosts completed.\n")