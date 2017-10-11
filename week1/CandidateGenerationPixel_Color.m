
function [pixelCandidates] = CandidateGenerationPixel_Color(im, space)
    switch space
        case 'normrgb'
            im=double(im);
            [pixelCandidates] = ThresholdsStrategy(im);
        case 'gaussian_thresholds'    
            im=double(im);
            [pixelCandidates] = GaussianFitWithThresholds(im);
        case 'hsv_ycbcr'
            [pixelCandidates] = HSVStrategy(im);
        otherwise
            error('Incorrect color space defined');
            return
    end
end   


function [pixelCandidates] = ThresholdsStrategy(im)
    %At first none pixel is candidate
    pixelCandidates = zeros(size(im,1),size(im,2));

    %% Method 1 (Tresholds by colors) %%
    %Find pixel candidates according to different colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>210 & im(:,:,2)<70 & im(:,:,3)<60); %Redish colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>15 & im(:,:,2)<90 & im(:,:,3)<190); %Blueish colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>15 & im(:,:,2)<15 & im(:,:,3)<15); %Blackish colors
end

function [pixelCandidates] = ThresholdsStrategy2(im)
    %At first none pixel is candidate
    pixelCandidates = zeros(size(im,1),size(im,2));

    %% Method 1 (Tresholds by colors) %%
    %Find pixel candidates according to different colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>70 & im(:,:,2)<70 & im(:,:,3)<60); %Redish colors
    pixelCandidates = pixelCandidates | (im(:,:,1)<40 & im(:,:,2)<100 & im(:,:,3)>70); %Blueish colors

end

function [pixelCandidates] = GaussianFitWithThresholds(im)
    %At first none pixel is candidate
    load('thresholds08.mat')

    pixelCandidates = zeros(size(im,1),size(im,2));

    for i=1:size(thresholds,2)
        pixelCandidates = pixelCandidates | (im(:,:,1) > thresholds(i).r_min & im(:,:,1)<thresholds(i).r_max & im(:,:,2)>thresholds(i).g_min & im(:,:,2)<thresholds(i).g_max & im(:,:,3)>thresholds(i).b_min & im(:,:,3)<thresholds(i).b_max ); 
    end
end

function [pixelCandidates] = HSVStrategy(im)
    im_hsv = rgb2hsv(im);
    mask_hsv_red = (im_hsv(:,:,1)<0.03 | im_hsv(:,:,1)>0.9); %Redish colors
    mask_hsv_blue = (im_hsv(:,:,1)<0.75 & im_hsv(:,:,1)>0.55); %Blueish colors

    im_ycbcr = rgb2ycbcr(im);
    mask_ycbcr_red = (im_ycbcr(:,:,3)<175 & im_ycbcr(:,:,3)>135); %Redish colors
    mask_ycbcr_blue = (im_ycbcr(:,:,2)<175 & im_ycbcr(:,:,2)>135); %Blueish colors

    mask_red = mask_hsv_red .* mask_ycbcr_red;
    mask_blue = mask_hsv_blue .* mask_ycbcr_blue;

    pixelCandidates = mask_red | mask_blue;
end