function CreateDir(directory, delete)
    if(delete)
        if (7==exist(directory,'dir'))
        rmdir(directory, 's');
        end
        status = mkdir(directory);
        if~status
            error(strcat('Directory creation /',directory));
        end
    elseif (7~=exist(directory,'dir'))
        status = mkdir(directory);
        if~status
            error(strcat('Directory creation /',directory));
        end
    end
end