
% 
% This code is for exploratory purposes
% 

%%% Experiment 1: How much time does Meanshift take
addpath('week5')
I = imread('datasets/train/00.001841.jpg');
tic
bw   = 0.2;
[Ims2, Nms2] = Ms2(I,bw);
toc
subplot(235); imshow(Ims2); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
% Result: 63s

%%% Experiment 2: How much time does it take if we rescale the image

Ires = imresize(I, 0.3);
bw   = 0.09;
tic
[Ims2, Nms2] = Ms2(Ires,bw);
toc
subplot(235); imshow(Ims2); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
% Results: High bandwidth slows a lot the time. Big image also.
% Resizing the image decreases substantially




%%% Experiment 3: 
I = imread('datasets/train/01.002870.jpg');
% I_ycbcr = rgb2ycbcr(I);
I_ycbcr = rgb2hsv(I);
% I_ycbcr = colorspace('rgb-> hsv',I);

I_ycbcr_res = imresize(I_ycbcr, 0.2);
bw   = 0.15;
tic
[Ims2, Nms2] =  Ms(I_ycbcr_res,bw);
toc
subplot(235); imshow(Ims2); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);
rgb = hsv2rgb(Ims2);


%%% Experiment 4: Filter with actual thresholds
[pixelCandidates1] = ColorSegmentation(I, 'blue');
[pixelCandidates2] = ColorSegmentation(I, 'red');
pixelCandidates = pixelCandidates1 | pixelCandidates2;

i2 = imresize(pixelCandidates, 5);
pixelCandidates = MorphologicalTransform(i2);





[pixelCandidates1] = ColorSegmentation(I, 'blue');
[pixelCandidates2] = ColorSegmentation(I, 'red');
pixelCandidates = pixelCandidates1 | pixelCandidates2;