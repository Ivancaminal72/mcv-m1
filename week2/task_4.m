addpath('../week1');
addpath('../week1/evaluation');

% Take files from training split
directory = '../datasets/train';
files = ListFiles(directory);

% Iterate over files and put signals on matrices
A = []; B = []; C = []; D = []; E = []; F = [];


for i=1:size(files,1)
    im = imread(strcat(directory,'/',files(i).name));
    mask = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'));
    [annotations, signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 

    for  j=1:size(annotations, 1)
      ann = annotations(j);
      % Apply Ceil function to obtain non zero integer pixel values
      ann.x = ceil(ann.x);
      ann.y = ceil(ann.y);
      ann.w = ceil(ann.w);
      ann.h = ceil(ann.h);
      
      signal = im(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1, :);
      signal = rgb2ycbcr(signal);
      
      signal_mask = mask(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1);
      only_signal = signal.*signal_mask;

      display(i)

      % Put all the pixels from each channel in different columns in a Nx3 matrix
      y = only_signal(:,:,1);
      Cb = only_signal(:,:,2);
      Cr = only_signal(:,:,3);
      format_img = [y(:), Cb(:), Cr(:)];
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

% Merge some signals and end with 3 groups 
G1 = [A; B; C];
G2 = [D;F];
G3 = [E];

% Choose the number of bins by observation
% 1) For the lumminance channel

PlotYHist(5, 1, 1, G1, 50);
PlotYHist(5, 1, 2, G1, 70);
PlotYHist(5, 1, 3, G1, 90);
PlotYHist(5, 1, 4, G1, 110);
PlotYHist(5, 1, 5, G1, 150);

% Result => bins = 110,
%   thresholds: G1 = 0.003, G2 = 0.005, G3 = 0.005
h_y_1 = PlotYHist(3, 1, 1, G1, 110, 'G1 (Y channel)');
h_y_2 = PlotYHist(3, 1, 2, G2, 110, 'G2 (Y channel)');
h_y_3 = PlotYHist(3, 1, 3, G3, 110, 'G3 (Y channel)');



% 2) For the Cb, Cr channels

PlotCbCrHist(1, 5, 1, G1, 20);
PlotCbCrHist(1, 5, 2, G1, 30);
PlotCbCrHist(1, 5, 3, G1, 40);
PlotCbCrHist(1, 5, 4, G1, 50);
PlotCbCrHist(1, 5, 5, G1, 70);

% Result => bins = 70, threshold = 0.2e-3
h_cbcr_1 = PlotCbCrHist(1, 3, 1, G1, 30);
h_cbcr_2 = PlotCbCrHist(1, 3, 2, G2, 30);
h_cbcr_3 = PlotCbCrHist(1, 3, 3, G3, 30);


save('normalized_histograms/h_y_1.mat', 'h_y_1')
save('normalized_histograms/h_y_2.mat', 'h_y_2')
save('normalized_histograms/h_y_3.mat', 'h_y_3')

save('normalized_histograms/h_cbcr_1.mat', 'h_cbcr_1')
save('normalized_histograms/h_cbcr_2.mat', 'h_cbcr_2')
save('normalized_histograms/h_cbcr_3.mat', 'h_cbcr_3')









