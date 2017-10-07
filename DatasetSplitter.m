%% BLOCK 1 - TASK 2
addpath('evaluation');
directory='C:\Users\Cris\Documents\GitHub\team8\TASK2'; % training set location


files = ListFiles(directory);
A={};
ci=1;
for i=1:size(files)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end
%% SPLIT SIGNALS TYPE E
files1 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files1)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files1(i).name(1:size(files1(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end

%% SPLIT SIGNALS TYPE C
files2 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files2)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files2(i).name(1:size(files2(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end
%% SPLIT SIGNALS TYPE D
files3 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files3)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files3(i).name(1:size(files3(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end

%% SPLIT SIGNALS TYPE A
files4 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files4)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files4(i).name(1:size(files4(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end
%% SPLIT SIGNALS TYPE F
files5 = ListFiles(directory);
A={};
ci=1;
for i=1:size(files5)
[annotations signs counter] = LoadAnnotations(strcat(directory, '/gt/gt.', files5(i).name(1:size(files5(i).name,2)-3), 'txt')); 
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
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\trainingset');
            else
            [SUCCESS,MESSAGE,MESSAGEID] = movefile(A{t,2},'C:\Users\Cris\Documents\GitHub\team8\TASK2\validationset');
            end
    end
end

 