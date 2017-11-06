function [uwcand] = TemplateMatching(mask, da, params, im)
    %Load the Generated Templates
    object = load ('./week4/templates/mean_train.mat');
    T = object.templates;
    %Compute edges of the image and the chamfer distance
    
    ime=findEdges_ycbcr(im);

    wcand = [];
    uwcand = [];
    [rows, cols] = size(ime);
    
    vcomb = getCombinations(da, params.dims, params.ffs); %width and height combinations
    
    for c = 1:length(vcomb)
        area = vcomb(c).w * vcomb(c).h;
        disp(sprintf("Combination %d/%d",c,length(vcomb)));
        %Don't compute improvable combinations
        if(area < da('all').min_area || area > da('all').max_area)
            disp('Filtration of combination: area');
            continue;
        end         
        
        %Set jump_y and jum_x values
        if(params.overlap)
            jump_y = round(vcomb(c).h*(1-params.jump));
            jump_x = round(vcomb(c).w*(1-params.jump));
        else 
            jump_y = vcomb(c).h;
            jump_x = vcomb(c).w;
        end              
        
        %Apply the four templates
        for ch =1:4
            temp = padarray(T(:,:,ch), [1 1], 0);%Add 1 pixel of zero padding
            temp = imresize(temp,[vcomb(c).h vcomb(c).w]); %Resize Template to the combination
            TE = edge(temp,'Canny', [0.5 0.9]); %Compute edges for every Template type (4 channels)                       
            
            %Sliding Loop
            for i = 1:jump_y:rows-(vcomb(c).h-1)
                for j = 1:jump_x:cols-(vcomb(c).w-1)
                    coords = struct('y', i, 'x', j, 'w', vcomb(c).w, 'h', vcomb(c).h, 'cy', i+round(vcomb(c).h/2), 'cx', j+round(vcomb(c).w/2), 'sum',  0);                   
                                                            
                    %Apply the Template to the image
                    result = ime(i:i+vcomb(c).h-1, j:j+vcomb(c).w-1).*TE;
                    coords.sum = sum(sum(result)); 
                    
                    %disp(coords.sum);
                    %Accept or not he window as a candidate
                    threshold = sum(sum(TE)) * params.threshold;
                    if(coords.sum <= threshold)
                        wcand = [wcand; coords];
                    end
                    
                end
            end
        end
    end
    disp(length(wcand));

    if(length(wcand)>1)
        overlapLimitDistance = 2*size(T,1); %The maximum distance that are considered 
        uwcand = getUnifiedWindowCandidates(wcand, overlapLimitDistance);
    elseif(length(wcand)==1)
        uwcand = struct('y', wcand(1).y, 'x', wcand(1).x, 'w', wcand(1).w, 'h', wcand(1).h);
    end
    showCandidates(im, ime, uwcand, wcand);
end

function uwcand = getUnifiedWindowCandidates(wcand, dist)
    uwcand = [];
    %Delete overlapped windows by distance
    %Algorithm to do it:
    for a=1:length(wcand)
        for b=1:length(wcand)
            if(a==b)
                continue;
            elseif(wcand(b).x == -1)
                continue;
            elseif(pdist([wcand(a).cy,wcand(a).cx; wcand(b).cy,wcand(b).cx]) < dist)
                if(wcand(a).sum < wcand(b).sum)
                    wcand(b).x = -1;
                else
                    wcand(a).x = -1;
                end
            end
        end
    end
    for a = 1:length(wcand)
        if(wcand(a).x ~= -1)
            uwcand = [uwcand; struct('y', wcand(a).y, 'x', wcand(a).x, 'w', wcand(a).w, 'h', wcand(a).h)];
        end
    end
end

function showCandidates(im, ime, uwcand, wcand)
    figure(1);
    subplot(1,1,1)
    imshow(im)
    % subplot(1,2,2)
    % imshow(ime)
    for i = 1:length(wcand)
        rectangle('Position',[wcand(i).x wcand(i).y wcand(i).w wcand(i).h],'EdgeColor','y','LineWidth',1 );
    end
    for i = 1:length(uwcand)
        rectangle('Position',[uwcand(i).x uwcand(i).y uwcand(i).w uwcand(i).h],'EdgeColor','r','LineWidth',1 );
    end
    waitforbuttonpress();
end

function vcomb = getCombinations(da, dims, ffs)
    %This function returns a vector of combinations of width and heigth.
    %The combinations are obtained considering that the values between the
    %intervals [min, max](obtained by the datasetAnalysis) are equiprobable.
    
    if(dims > 0 && ffs > 0)
        %Obtain the division period
        per_w = (da('all').w_max-da('all').w_min)/(dims+1);
        per_ff = (da('all').ff_max-da('all').ff_min)/(ffs+1);
        %Preallocate vcomb
        vcomb(1:(dims*ffs)) = struct('w', 0, 'h', 0);
        %Calculate md and mf vectors of indices
        md=zeros(dims*ffs,1); %multiplier of the period of the dimension
        mf=zeros(dims*ffs,1); %multiplier of the period of the form_factor
        for d = 1:dims
            for f = 1:ffs
                c = f+(d-1)*ffs;
                md(c) = d;
                mf(c) = f;
            end
        end
        
        %Calculate width and heigth combinations
        for c = 1:(dims*ffs)          
            vcomb(c).w = round(da('all').w_min+per_w*md(c));
            vcomb(c).h = round((da('all').w_min+per_w*md(c))/(da('all').ff_min+per_ff*mf(c)));
        end
        
    else
        error('incorrect number of dims or ffs');
    end   
end


function ime = findEdges_gray(im)
    im_g = rgb2gray(im);
    [ime, th] = edge(im_g,'Canny', [0.0112    0.281]);
    ime = bwdist(ime);
    %imshow(ime)
    %waitforbuttonpress();
end

function ime = findEdges_ycbcr(im)
    %imshow(im)
    %waitforbuttonpress();
    im_g = rgb2ycbcr(im);
    th = [0.3    0.7];
    ime_cb = edge(im_g(:,:,2),'Canny', th);
    ime_cr = edge(im_g(:,:,3),'Canny', th);
    ime = ime_cb | ime_cr;
    %imshow(ime)
    %waitforbuttonpress();
    ime = bwdist(ime);
    
end
