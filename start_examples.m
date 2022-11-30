close all
clear all
% Main script for running examples

% add folders to search path
path_folder = pwd;
addpath(genpath(path_folder));

%% Start_examples run parameter
% if you want tu run that part assign 1 of not 0
run_basics_GPU            = 1;
run_PDE_mesh              = 1;
run_dalauney_mesh         = 1;
run_STL_mesh              = 1;
run_areas                 = 1;
run_vectorize             = 1;
run_areas_vectorize       = 1;
run_compare_stiffness     = 1;
run_compare_elasticity    = 1;

%% Scripts parameters
n_2D = 100; % Number of boundary points in 2D mesh

lvl = [1,1.5]%, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6]; % 3D mesh levels (used by compare_stiffness.m, compare_elasticity_3D.m)


fx = @(x)2*(cos(x).*(1+sin(x))); fy=@(y)sin(y);  % 2D shape boundary description function
t = (linspace(0,n_2D-1,n_2D)*(2*pi/n_2D)); % linearly distributed param t
x = fx(t); y = fy(t); % get x and y boundry points

stl_file_name = 'hrnek.stl'; % name of stl file from which to load the mesh

%% Examples 1-4 (basics how to use GPU in MATLAB)  
if run_basics_GPU 
    example_1_gpuArrayDeclaration
    example_2_memoryAlocation
    example_3_memoryAlocationGPU
    example_4_resourcesCosts
end

%% Create 2D mesh
if run_areas || run_vectorize || run_PDE_mesh || run_areas_vectorize
    fprintf("PDE meshGenerator started.\n")
    %figure;
    [coordinates, elements] = meshGenerator(x,y); % generates 2D mesh (coordinates, elements) using PDE toolbox
    axis square; axis tight; enlarge_axis; % format  figure output
    fprintf("PDE meshGenerator completed.\n")
end

if run_dalauney_mesh
    figure;
    example_9_meshDelaunay % prints mesh using Delaunay function
    axis square; axis tight; enlarge_axis; % format  figure output
end

%% Create 3D mesh from STL
if run_STL_mesh
    fprintf("Mesh from STL started.\n")
    figure;
    [~,~] = meshFromSTL(stl_file_name);
    %axis square; axis tight; enlarge_axis;
    fprintf("Mesh from STL completed.\n")
end

%% Calculate area of the 2D mesh
if run_areas
    example_5_gaussMethod % calculate area using Gauss method
    example_6_heron % calculate area using Herons formula (coordinates, elements needed)
    example_7_det2x2 % calculate area using 2x2 det (coordinates, elements needed)
    example_8_det3x3 % calculate area using 3x3 det (coordinates, elements needed)
   
end

%% Example vectorization
if run_vectorize
    example_10_vectorization
end

%% Vectorize and calculate area of the 2D mesh
if run_areas_vectorize
    example_11_vectorize_det2x2 % vectorized calculate area using Herons formula (coordinates, elements needed)
    example_12_vectorize_det3x3 % vectorized calculate area using 2x2 det (coordinates, elements needed)
    example_13_vectorize_heron % vectorized calculate area using 3x3 det (coordinates, elements needed)
end

%% Compare asembly times of stiffness matrix (GPU vs CPU)
if run_compare_stiffness
    example_14_compare_stiffness
end

%% Compare time of calculation of elasticity (GPU vs CPU)
if run_compare_elasticity
    example_15_compare_elasticity_3D
end
