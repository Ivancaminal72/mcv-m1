clear all; close all;
g = imread('cameraman.tif');

% Matlab operators
se = strel('square', 5); % 5 points SE definition
    tic;  
YD = imdilate(g, se);
    TD = toc;
    tic;
YE = imerode(g,se);
    TE = toc;
    tic;
YO = imopen (g,se);
    TO = toc;
    tic;
YC = imclose (g,se);
    TC = toc;
    tic;
YTH = imtophat (g,se);
    TTH= toc;

% My operators
my_se = se.Neighborhood; % 5 points structuring element
    tic;
yd = mydilate(g, my_se);
    td=toc;
    tic;
ye = myerode(g,my_se);
    te=toc;
    tic;
yo = myopening(g,my_se);
    to=toc;
    tic;
yc = myclosing (g,my_se);
    tc=toc;
    tic;
yth = mytophat(g,my_se);
    tth=toc;
% Measure the computational efficiency 
Efficiency_mydilate=abs(YD-yd);
Efficiency_myerode=abs(YE-ye);
Efficiency_myopening=abs(YO-yo);
Efficiency_myclosing=abs(YC-yc);
Efficiency_mytophat=abs(YTH-yth);

% PLOT original image, imdilate image, mydilate image and null difference
figure(1)
subplot(2,2,1)
imshow(g)
title('original image')
subplot (2,2,2)
imshow(YD)
title ('imdilate')
subplot(2,2,3)
imshow(yd)
title('mydilate')
subplot(2,2,4)
imshow (Efficiency_mydilate)
title('Null difference')

% PLOT original image, imerode image, myerode image and null difference
figure(2)
subplot(2,2,1)
imshow(g)
title('original image')
subplot (2,2,2)
imshow(YE)
title ('imerode')
subplot(2,2,3)
imshow(ye)
title('myerode')
subplot(2,2,4)
imshow (Efficiency_myerode)
title('Null difference')

% PLOT original image, imopen image, myopening image and null difference
figure(3)
subplot(2,2,1)
imshow(g)
title('original image')
subplot (2,2,2)
imshow(YO)
title ('imopen')
subplot(2,2,3)
imshow(yo)
title('myopening')
subplot(2,2,4)
imshow (Efficiency_myopening)
title('Null difference')

% PLOT original image, imclose image, myclosing image and null difference
figure(4)
subplot(2,2,1)
imshow(g)
title('original image')
subplot (2,2,2)
imshow(YC)
title ('imclose')
subplot(2,2,3)
imshow(yc)
title('myclosing')
subplot(2,2,4)
imshow (Efficiency_myclosing)
title('Null difference')

% PLOT original image, imtophat image, mytophat image and null difference
figure(5)
subplot(2,2,1)
imshow(g)
title('original image')
subplot (2,2,2)
imshow(YTH)
title ('imtophat')
subplot(2,2,3)
imshow(yth)
title('mytophat')
subplot(2,2,4)
imshow (Efficiency_mytophat)
title('Null difference')

