function [mask]=ColorSegmentation(image,color)
% Convert image to HSV color space

 image_hsv = colorspace('rgb-> hsv',image);

 % Split the channels
 h = image_hsv(:,:,1);
 s = image_hsv(:,:,2);
 v = image_hsv(:,:,3);
 
 % Create a blank mask
 [row,colum,c]=size(image_hsv);
 mask = zeros(row,colum);
 
if strcmp(color,'blue')==1
  % Segmentation for blue signals
  mask = h < 250 & h > 180 & s > 0.5;
  mask=uint8(mask);
elseif strcmp(color,'red')==1
  % Segmentation for red signals
  mask = ((h < 10 & h >= 0) | (h <= 360 & h > 350)) & s > 0.5 & v > 0.25;
  mask=uint8(mask);
else
    error('Bad input arguments')
end