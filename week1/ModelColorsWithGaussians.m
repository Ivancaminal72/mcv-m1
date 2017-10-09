addpath('evaluation');

function [mask] = GetMask(directory, file)
  mask = imread(strcat(directory, '/mask/mask.', file.name(1:size(file.name,2)-3), 'png'));
end

function [A] = Clean(A)
  A(A > 240) = 0;
  A(A < 10) = 0;
  A = A(any(A,2),:);
end

function [means, stds] = FitGaussianModel(A)
  means = mean(A);
  stds = std(A);
end

function [thresholds] = GenerateThresholdsFromGaussianModel(means, stds, variance)
  thresholds = zeros(3,2);
  thresholds = [max(0, means' - (stds'/2)*variance), min(255, means' + (stds'/2))*variance];
  % r [th1, th2]
  % g [th1, th2]
  % b [th1, th2]


end

function [thresholds] = GenerateThresholdsFromData(A, variance, thresholds, sign_name)
  [means, stds] = FitGaussianModel(A);
  [th] = GenerateThresholdsFromGaussianModel(means, stds, variance);

  thresholds(size(thresholds,2)+1) = struct(
    'name', sign_name, 
    'r_min', th(1,1) , 'r_max', th(1,2),
    'g_min', th(2,1) , 'g_max', th(2,2),
    'b_min', th(3,1) , 'b_max', th(3,2)
    );
end

function PlotSignHist(f,c,i, A, name)
  subplot(f,c,i*3+1)
  histfit(A(:,1)(:), 50)
  title (strcat(name, " signals (R)")); axis([0, 255, 0, 40000])
  subplot(f,c,i*3+2)
  histfit(A(:,2)(:), 50)
  title (strcat(name, " signals (R)"));axis([0, 255, 0, 40000])
  subplot(f,c,i*3+3)
  histfit(A(:,3)(:), 50)
  title (strcat(name, " signals (R)"));axis([0, 255, 0, 40000])
end

A = []; B = []; C = []; D = []; E = []; F = [];

directory = 'datasets/train';
files = ListFiles(directory);

for i=1:size(files,1)
    im = imread(strcat(directory,'/',files(i).name));
    mask = GetMask(directory, files(i));
    [annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
    for  j=1:size(annotations, 1)
      ann = annotations(j);
      % Apply Ceil function to obtain non zero integer pixel values
      ann.x = ceil(ann.x);
      ann.y = ceil(ann.y);
      ann.w = ceil(ann.w);
      ann.h = ceil(ann.h);
      
      signal = im(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1, :);
      signal_mask = mask(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1);
      only_signal = signal.*signal_mask;

      display(i)
      fflush(stdout);

      % Put all the pixels from each channel in different columns in a Nx3 matrix
      format_img = [only_signal(:,:,1)(:), only_signal(:,:,2)(:), only_signal(:,:,3)(:)];
      % Delete rows with only zeros
      format_img = format_img(any(format_img,2),:);

      switch signs{j}
        case 'A'
            A = [A ; format_img];
        case 'B'
            B = [B ; format_img];
        case 'C'
            C = [C ; format_img];
        case 'D'
            D = [D ; format_img];
        case 'E'
            E = [E ; format_img];
        case 'F'
            F = [F ; format_img];
      end
    end
end

A = Clean(A);
B = Clean(B);
C = Clean(C);
D = Clean(D);
E = Clean(E);
F = Clean(F);

PlotSignHist(6,3,0,A, 'A');
PlotSignHist(6,3,1,B, 'B');
PlotSignHist(6,3,2,C, 'C');
PlotSignHist(6,3,3,D, 'D');
PlotSignHist(6,3,4,E, 'E');
PlotSignHist(6,3,5,F, 'F');


thresholds = struct([]);
[thresholds] = GenerateThresholdsFromData(A, 0.7, thresholds, 'A');
[thresholds] = GenerateThresholdsFromData(B, 0.7, thresholds, 'B');
[thresholds] = GenerateThresholdsFromData(C, 0.7, thresholds, 'C');
[thresholds] = GenerateThresholdsFromData(D, 0.7, thresholds, 'D');
[thresholds] = GenerateThresholdsFromData(E, 0.7, thresholds, 'E');
[thresholds] = GenerateThresholdsFromData(F, 0.7, thresholds, 'F');
save('thresholds07.mat', 'thresholds')


thresholds = struct([]);
[thresholds] = GenerateThresholdsFromData(A, 0.8, thresholds, 'A');
[thresholds] = GenerateThresholdsFromData(B, 0.8, thresholds, 'B');
[thresholds] = GenerateThresholdsFromData(C, 0.8, thresholds, 'C');
[thresholds] = GenerateThresholdsFromData(D, 0.8, thresholds, 'D');
[thresholds] = GenerateThresholdsFromData(E, 0.8, thresholds, 'E');
[thresholds] = GenerateThresholdsFromData(F, 0.8, thresholds, 'F');
save('thresholds08.mat', 'thresholds')
thresholds = struct([]);
[thresholds] = GenerateThresholdsFromData(A, 0.9, thresholds, 'A');
[thresholds] = GenerateThresholdsFromData(B, 0.9, thresholds, 'B');
[thresholds] = GenerateThresholdsFromData(C, 0.9, thresholds, 'C');
[thresholds] = GenerateThresholdsFromData(D, 0.9, thresholds, 'D');
[thresholds] = GenerateThresholdsFromData(E, 0.9, thresholds, 'E');
[thresholds] = GenerateThresholdsFromData(F, 0.9, thresholds, 'F');
save('thresholds09.mat', 'thresholds')
