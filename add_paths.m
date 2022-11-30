% This script adds the absolute location of
% the shared functions to the path

%dir1='library_vectorization';             %original library
dir2='library_vectorization_faster';      %improved library
dir3='library_vectorization_gpu';      %GPU library
dir4='other';   %minor scripts cleanup
%warning('off','MATLAB:rmpath:DirNotFound');

%path1 = pwd;

%rmpath(genpath(path1));

%cd ..   
path_folder = pwd;
%if ( isunix )
%    addpath(genpath(path2));
%else
addpath(genpath(path_folder));
%end

[ver, date] = version;     
%year=str2double(date(end-1:end));

if (str2double(ver(1:4)) >= 9.1)       %since version 9.1 there is an aritmetic expansion
    %cd(dir1); rmpath(genpath(pwd));
else
    cd(dir2); rmpath(genpath(pwd));
    cd(dir3); rmpath(genpath(pwd));
    cd(dir4); rmpath(genpath(pwd));
end

cd(path_folder)



