
function [pixelCandidates] = CandidateGenerationPixel_Color(im, space)

    im=double(im);

    switch space
        case 'normrgb'
            [pixelCandidates] = ThresholdsStrategy2(im);
        case 'gaussian_thresholds'    
            [pixelCandidates] = GaussianFitWithThresholds(im);
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
    pixelCandidates = pixelCandidates | (im(:,:,1)>210 & im(:,:,2)<15 & im(:,:,3)<15); %Redish colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>15 & im(:,:,2)<90 & im(:,:,3)<190); %Blueish colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>15 & im(:,:,2)<15 & im(:,:,3)<15); %Blackish colors
end

function [pixelCandidates] = ThresholdsStrategy2(im)
    %At first none pixel is candidate
    pixelCandidates = zeros(size(im,1),size(im,2));

    %% Method 1 (Tresholds by colors) %%
    %Find pixel candidates according to different colors
    pixelCandidates = pixelCandidates | (im(:,:,1)>70 & im(:,:,2)<40 & im(:,:,3)<40); %Redish colors
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