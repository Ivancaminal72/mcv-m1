
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
        case 'hsv_ycbcr+morph_op'
            [pixelCandidates] = MorphOpStrategy(im);
        case 'hist_packprop'
            [pixelCandidates] = HistogramBackprop(im);
        otherwise
            error('Incorrect color space defined');
    end
end   


function [pixelCandidates] = MorphOpStrategy(im)
    pixelCandidates = HSVStrategy(im);
    se = ones(17);
    pixelCandidates = imclose(imopen(pixelCandidates, se), se);
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

function [pixelCandidates] = HistogramBackprop(im)
    pixelCandidates = zeros(size(im,1),size(im,2));

    im_ycbcr = rgb2ycbcr(im);

    load('../week2/normalized_histograms/h_y_1.mat')
    load('../week2/normalized_histograms/h_y_2.mat')
    load('../week2/normalized_histograms/h_y_3.mat')
    load('../week2/normalized_histograms/h_cbcr_1.mat')
    load('../week2/normalized_histograms/h_cbcr_2.mat')
    load('../week2/normalized_histograms/h_cbcr_3.mat')
    addpath('../week2')


    for i=1:size(im_ycbcr,1)
        for j=1:size(im_ycbcr,2)
            pixel = im_ycbcr(i,j,:);
            pixel = pixel(:);

            pixelValue = 0;

            % Probabilites for the Y channels
            p_y_1 = HistogramBackpropagation(h_y_1, pixel(1));
            p_y_2 = HistogramBackpropagation(h_y_2, pixel(1));
            p_y_3 = HistogramBackpropagation(h_y_3, pixel(1));

            % Probabilities for the CbCr channels
            p_cbcr_1 = HistogramBackpropagation(h_cbcr_1, [pixel(2); pixel(3)]);
            p_cbcr_2 = HistogramBackpropagation(h_cbcr_2, [pixel(2); pixel(3)]);
            p_cbcr_3 = HistogramBackpropagation(h_cbcr_3, [pixel(2); pixel(3)]);

            % Return 1 if it complies with certain thresholds
            pixelValue = pixelValue | (p_y_1 > 0.005 & p_cbcr_1 > 0.6e-3);
            pixelValue = pixelValue | (p_y_2 > 0.01 & p_cbcr_2 > 0.6e-3);
            pixelValue = pixelValue | (p_y_3 > 0.015 & p_cbcr_3 > 0.6e-3);

            pixelCandidates(i,j) = pixelValue;
        end
    end
end