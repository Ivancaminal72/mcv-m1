%% BLOCK 1 - TASK 2
addpath('evaluation');
dir_original='C:\Users\Ivan\Documents\GitHub\team8\datasets\original'; % original set location
dir_train='C:\Users\Ivan\Documents\GitHub\team8\datasets\train'; % training set location
dir_validation='C:\Users\Ivan\Documents\GitHub\team8\datasets\validation'; % validation set location

files = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
Type_B=0; 
for h=1:num
    if A{h,1}== 'B'
      Type_B=Type_B+1; 
    end
end
count=0;
for t=1:num
    if A{t,1}== 'B'
            count=count +1
            if count <= 10 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end
%% SPLIT SIGNALS TYPE E
files1 = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files1)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files1(i).name(1:size(files1(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
            count=count +1
            if count <= 27 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end

%% SPLIT SIGNALS TYPE C
files2 = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files2)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files2(i).name(1:size(files2(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
            count=count +1
            if count <= 32 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end
%% SPLIT SIGNALS TYPE D
files3 = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files3)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files3(i).name(1:size(files3(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
            count=count +1
            if count <= 70 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end

%% SPLIT SIGNALS TYPE A
files4 = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files4)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files4(i).name(1:size(files4(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
            count=count +1
            if count <= 50 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end
%% SPLIT SIGNALS TYPE F
files5 = ListFiles(dir_original);
A={};
ci=1;
for i=1:size(files5)
[annotations signs counter] = LoadAnnotations(strcat(dir_original, '/gt/gt.', files5(i).name(1:size(files5(i).name,2)-3), 'txt')); 
    if counter >1
        for j=1:counter
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
            count=count +1
            if count <= 50 
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_train);
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},dir_validation);
            end
    end
end

 