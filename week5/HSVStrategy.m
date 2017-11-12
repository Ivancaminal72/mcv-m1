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