close all
clear all
% for getting dependencies for scripts in current directory
dir_listing = dir; % get files from current directory

print_info = 1; % for print info 1 else 0
number_of_files_copied = 0; % copied files counter



file_ignore = [".", ".."]; % files to ignore
existing_dependencies = strings(1,numel(dir_listing));
existing_dependencies_dir = strings(1);
dep_dir_name = "Dependencies"; % name of directory for coping dependencies
[dependency_dir_created, msg] = mkdir(dep_dir_name); % create dependency directory

% if folder already exists look for existing dependencies
if dependency_dir_created && msg == "Directory already exists."
    if print_info
        fprintf("Directory %s for dependencies exists. Let's check it!\n", dep_dir_name);
    end
    %cd(dep_dir_name);
    directories = genpath(pwd);
    folders = split(directories,';');
    folders = get_string_array_from_cell(folders);
    for folder=1:numel(folders)
        if folders(folder) ~= pwd && folders(folder) ~= ""
            cd(folders(folder))
        end
        dir_dep_listing = dir;
        dir_dep_listing_name = strings(1,numel(dir_dep_listing));
        for i=1:numel(dir_dep_listing)
            if dir_dep_listing(i).isdir || ismember(dir_dep_listing(i).name,file_ignore)
                continue
            end
            dir_dep_listing_name(i) = join([dir_dep_listing(i).folder '\' dir_dep_listing(i).name]);
        end
        existing_dependencies = unique(cat(2,dir_dep_listing_name, existing_dependencies));
        if folders(folder) ~= pwd
            cd("..")
        end
    end
    % return to root
    %cd("..");
end


for i=1:numel(dir_listing)
    if dir_listing(i).isdir || ismember(dir_listing(i).name,file_ignore)
        continue
    end
    existing_dependencies(end+1) = join([dir_listing(i).folder '\' dir_listing(i).name]);
end

cd(dep_dir_name);

for i=1:numel(dir_listing)
    file = dir_listing(i);

    % ignore dirs
    if file.isdir
        continue
    end

    % ignore files defined at start of the script
    if ismember(file.name,file_ignore)
        continue
    end
    
    % get array of script dependencies
    file_dependencies = matlab.codetools.requiredFilesAndProducts(file.name);
    file_dependencies = get_string_array_from_cell(file_dependencies);
    

    for j=1:numel(file_dependencies)
        dep_file = file_dependencies(j);
        dummy = split(dep_file,'\');
        dep_file_name = dummy(end);
        dep_dir_file_name = dummy(end-1);

        % ignore files existing in current dir
        if ismember(dep_file_name, existing_dependencies)
            continue
        end

        % ignore files already added to dependency list
        if ismember(dep_file, existing_dependencies)
            continue
        end

        % check if dir for dependencies exists if not create one
        if dependency_dir_created == 0
            dependency_dir_created = mkdir(dep_dir_name);
        end
        
        if ~ismember(dep_dir_file_name, existing_dependencies_dir)
            %cd(dep_dir_name)
            mkdir(dep_dir_file_name)
            existing_dependencies_dir(end+1) = dep_dir_file_name;
            %cd('..')
        end
        
        %cd(dep_dir_name)

        if print_info
            fprintf("For %s copying dependecy %s. ", file.name, dep_file_name);
        end
        [status,msg] = copyfile(dep_file,dep_dir_file_name);
        
        if print_info
            if isempty(msg)
                fprintf("Copy status %d\n", status);
            else
                fprintf("Copy message %s, status %d\n", msg, status);
            end
        end
        existing_dependencies(end+1) = dep_file;
        number_of_files_copied = number_of_files_copied + 1;
    end 
end

% if created folder is empty, delete it
if dependency_dir_created
    %cd(dep_dir_name);
    dir_dep_listing = dir;
    cd("..") 
    if numel(dir_dep_listing) == 2
        rmdir(dep_dir_name)
    else
        % else add it to search path
        addpath(dep_dir_name)
    end
              
end

if print_info && number_of_files_copied >= 1
    fprintf("Dependencies added to directory: %s\n", dep_dir_name);
end

cd('..')
fprintf("Finished!\nNumber of files copied: %d\n", number_of_files_copied);

function string_array = get_string_array_from_cell(cell_array)
    ne = numel(cell_array);
    string_array = strings(1,ne);
    for i=1:ne
        string_array(i) = cell_array(i);
    end
end