addpath('evaluation');

function [mask] = GetMask(directory, file)
  mask = imread(strcat(directory, '/mask/mask.', file.name(1:size(file.name,2)-3), 'png'));
end

A = []; B = []; C = []; D = []; E = []; F = [];

directory = 'datasets/train';
files = ListFiles(directory);

for i=1:size(files,1)
%for i=1:size(files,1)
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



subplot(3,3,1)
histfit(A(:,1)(:), 20)
title ("A signals (R)"); axis([0, 255, 0, 100000])
subplot(3,3,2)
histfit(A(:,2)(:), 20)
title ("A signals (G)");axis([0, 255, 0, 100000])
subplot(3,3,3)
histfit(A(:,3)(:), 20)
title ("A signals (B)");axis([0, 255, 0, 100000])

subplot(3,3,4)
histfit(B(:,1)(:), 20)
title ("B signals (R)");axis([0, 255, 0, 100000])
subplot(3,3,5)
histfit(B(:,2)(:), 20)
title ("B signals (G)");axis([0, 255, 0, 100000])
subplot(3,3,6)
histfit(B(:,3)(:), 20)
title ("B signals (B)");axis([0, 255, 0, 100000])

subplot(3,3,7)
histfit(C(:,1)(:), 20)
title ("C signals (R)");axis([0, 255, 0, 100000])
subplot(3,3,8)
histfit(C(:,2)(:), 20)
title ("C signals (G)");axis([0, 255, 0, 100000])
subplot(3,3,9)
histfit(C(:,3)(:), 20)
title ("C signals (B)");axis([0, 255, 0, 100000])



