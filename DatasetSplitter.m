function [ TYPE_SIGNALS ] = DatasetSplitter(directory, directory_trainingset, directory_validationset )

%directory='C:\Users\Cris\Documents\GitHub\team8\train';
%directory_trainingset='C:\Users\Cris\Documents\GitHub\team8\train\trainingset'; 
%directory_validationset= 'C:\Users\Cris\Documents\GitHub\team8\train\validationset';
directory='C:\Users\Ivan\Documents\GitHub\team8\datasets\original';
directory_trainingset='C:\Users\Ivan\Documents\GitHub\team8\datasets\trainingset'; 
directory_validationset= 'C:\Users\Ivan\Documents\GitHub\team8\datasets\validationset';

addpath('evaluation');

directory_trainingset_mask=strcat(directory_trainingset,'/mask');
directory_validationset_mask=strcat(directory_validationset,'/mask');
if (7==exist(directory_trainingset,'dir'))
    rmdir(directory_trainingset, 's');
end
if (7==exist(directory_validationset,'dir'))
    rmdir(directory_validationset, 's');
end
status = mkdir(directory_trainingset_mask);
if~status
    error('directory_trainingset_mask creation');
end
status = mkdir(directory_validationset_mask);
if~status
    error('directory_validationset_mask creation');
end

%% SPLIT SIGNALS TYPE B

files = ListFiles(directory);
A={};
ci=1;
for i=1:size(files)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
OA=0;OB=0;OC=0;OD=0;OE=0;OF=0;
Type_B=0; 
for h=1:num
    if A{h,1}== 'B'
      Type_B=Type_B+1;
      OB=OB+1;
    elseif A{h,1}== 'C'
      OC=OC+1;
    elseif A{h,1}== 'D'
      OD=OD+1;
    elseif A{h,1}== 'E'
      OE=OE+1;
    elseif A{h,1}== 'F'
      OF=OF+1;
    else A{h,1}== 'A'
      OA=OA+1;
    end
    
end
count=0;
for t=1:num
    if A{t,1}== 'B'
            count=count +1;
            if count <= 10 
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end
%% SPLIT SIGNALS TYPE E
files1 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files1)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files1(i).name(1:size(files1(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files1(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files1(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
Type_E=0; 
for h=1:num
    if A{h,1}== 'E'
      Type_E=Type_E+1; 
    end
end

count=0;
for t=1:num
    if A{t,1}== 'E'
            count=count +1;
            if count <= 27
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end
%% SPLIT SIGNALS TYPE C
files2 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files2)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files2(i).name(1:size(files2(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files2(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files2(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
Type_C=0; 
for h=1:num
    if A{h,1}== 'C'
      Type_C=Type_C+1; 
    end
end

count=0;
for t=1:num
    if A{t,1}== 'C'
            count=count +1;
            if count <= 32 
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end
%% SPLIT SIGNALS TYPE D
files3 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files3)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files3(i).name(1:size(files3(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files3(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files3(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
Type_D=0; 
for h=1:num
    if A{h,1}== 'D'
      Type_D=Type_D+1; 
    end
end

count=0;
for t=1:num
    if A{t,1}== 'D'
            count=count +1;
            if count <= 70 
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end
%% SPLIT SIGNALS TYPE A
files4 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files4)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files4(i).name(1:size(files4(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files4(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files4(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
Type_A=0; 
for h=1:num
    if A{h,1}== 'A'
      Type_A=Type_A+1; 
    end
end

count=0;
for t=1:num
    if A{t,1}== 'A'
            count=count +1;
            if count <= 50 
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end
%% SPLIT SIGNALS TYPE F
files5 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files5)
[annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files5(i).name(1:size(files5(i).name,2)-3), 'txt')); 
    if size(annotations, 1) >1
        for j=1:size(annotations, 1)
            A(ci,1)=signs(j);
            A(ci,2)=cellstr(files5(i).name);
            ci=ci+1;
        end 
    else
    A(ci,1)=signs;
    A(ci,2)=cellstr(files5(i).name);
    ci=ci+1;
    end
end
num=size(A,1);
Type_F=0; 
for h=1:num
    if A{h,1}== 'F'
      Type_F=Type_F+1; 
    end
end

count=0;
for t=1:num
    if A{t,1}== 'F'
            count=count +1;
            if count <= 50 
            copyfile(strcat(directory,'\',A{t,2}),directory_trainingset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_trainingset_mask);
            else
            copyfile(strcat(directory,'\',A{t,2}),directory_validationset);
            copyfile(strcat(directory,'\mask\mask.',A{t,2}(1:size(A{t,2},2)-3),'png'),directory_validationset_mask);
            end
    end
end

TYPE_SIGNALS=[OA,OB,OC,OD,OE,OF];

end

% [SUCCESS,MESSAGE,MESSAGEID] = copyfile(strcat(directory,'\',A{1,2}),'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');


