function [uwcand] = HoughMethod(da, params, im)
    %Compute edges of the image and the chamfer distance
    imshow(im);
    waitforbuttonpress();
    ime=findEdges_ycbcr(im);
    %ime=findEdges_gray(im);
    
    %Compute hough transform
    [H,theta,rho] = hough(ime);
    maxvotes = round(15*mean(mean(H)));
    for i=1:size(H,1)
        for j=1:size(H,2)
            if(H(i,j) > maxvotes)
                H(i,j) = 0;
            end
        end
    end
    figure(1);
    surf(H);
    waitforbuttonpress();
    peaks = struct();
    peaks.ori = houghpeaks(H,params.numpeaks);
    size(peaks.ori,1)
    %sort(peaks.ori,2);
    %disp(peaks.ori(:,2));
    
    wcand = [];
    uwcand = [];
    [rows, cols] = size(ime);
    
    %Get Horizontal lines theta = 90deg
    peaks.h = getLines(peaks.ori,90,params.t);
    size(peaks.h,1)
    %Get Vertical lines theta = 0deg
    peaks.v = getLines(peaks.ori,0,params.t); 
    %Get Tilted lines theta = 45deg
    peaks.t45 = getLines(peaks.ori,45,params.tt); 
    %Get Tilted lines theta = 135deg
    peaks.t135 = getLines(peaks.ori,135,params.tt); 
                
    %Find windows with Rectangular signals
    wcand = findRectangularSignals(wcand, da, peaks);
    %Find windows with Triangular signals
    %Find windows with Circuar signals          
    
    disp(length(wcand));

    if(length(wcand)>1)        
        %uwcand = getUnifiedWindowCandidates(wcand);
        uwcand = wcand;
    elseif(length(wcand)==1)
        uwcand = wcand;
    end
    showCandidates(im, ime, uwcand, wcand, theta, rho, [peaks.h; peaks.v]);
end

function showCandidates(im, ime, uwcand, wcand, T, R, P)
    figure(1);
    subplot(1,1,1)
    imshow(im)
    %subplot(1,2,2)
    %imshow(ime)
    hold on
    lines = houghlines(ime,T,R,P,'FillGap',5,'MinLength',7);
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    end
    for i = 1:length(wcand)
        rectangle('Position',[wcand(i).x wcand(i).y wcand(i).w wcand(i).h],'EdgeColor','y','LineWidth',1 );
    end
    for i = 1:length(uwcand)
        rectangle('Position',[uwcand(i).x uwcand(i).y uwcand(i).w uwcand(i).h],'EdgeColor','r','LineWidth',1 );
    end
    hold off
    waitforbuttonpress();
end

function point = findIntersection(line_a, line_b)
    A = [sind(line_a(2)) cosd(line_a(2))];
    A = [A; [sind(line_b(2)) cosd(line_b(2))]];
    B = [line_a(1); line_b(1)];
    point = mldivide(A,B);
    point = round(point);
end

function peaks = getLines(allpeaks,theta, tol)
    peaks = [];
    for i=1:size(allpeaks,1)
        if(allpeaks(i,2)<theta+tol && allpeaks(i,2)>theta-tol)
        peaks = [peaks; allpeaks(i,:)];
        end
    end
end

function uwcand = getUnifiedWindowCandidates(wcand)
end

function ime = findEdges_gray(im)
    im_g = rgb2gray(im);
    [ime, ~] = edge(im_g,'Canny', [0.01    0.1]);
    imshow(ime)
    waitforbuttonpress();
end

function ime = findEdges_ycbcr(im)
    %imshow(im)
    %waitforbuttonpress();
    im_g = rgb2ycbcr(im);
    th = [0.1    0.4];
    ime_cb = edge(im_g(:,:,2),'Canny', th);
    ime_cr = edge(im_g(:,:,3),'Canny', th);
    ime = ime_cb | ime_cr;  
    imshow(ime)
    waitforbuttonpress();
end

function wcand = findRectangularSignals(wcand, da, peaks)
    imgh = 1236;
    imgw = 1628;
    newcand = struct();
    for ia = 1:size(peaks.h,1)
        for ib = 1:size(peaks.h,1)
            if(ia == ib)
                continue;
            else
                for ic = 1:size(peaks.v,1)
                    for id = 1:size(peaks.v,1)
                        if(ic == id)
                            continue;
                        else                            
                            pa = findIntersection(peaks.h(ib,:), peaks.v(ic,:));                            
                            pb = findIntersection(peaks.h(ia,:), peaks.v(ic,:));
                            if(pa(1) <= pb(1) || pa(1)>imgh || pa(2)>imgw || pb(1)>imgh || pb(2)>imgw)
                                %PROBLEM: Intersections out of img size?!!
                                continue;                                
                                else                                
                                pc = findIntersection(peaks.h(ib,:), peaks.v(id,:));
                                if(pc(2) <= pa(2) || pc(1)>imgh || pc(2)>imgw)
                                    continue;
                                else                                    
                                    pd = findIntersection(peaks.h(ia,:), peaks.v(id,:));                                    
                                    if(pc(1) <= pd(1) || pd(1)>imgh || pd(2)>imgw)
                                        continue;
                                    elseif(pd(2) <= pb(2))
                                        continue;
                                    else
                                        newcand.h = ((pa(1)-pb(1))+(pc(1)-pd(1)))/2;
                                        newcand.w = ((pc(2)-pa(2))+(pd(1)-pb(1)))/2;
                                        area = newcand.h*newcand.w;
                                        if(newcand.h > da('all').h_max || newcand.h < da('all').h_min || ...
                                                newcand.w > da('all').w_max || newcand.w < da('all').w_min)
                                            continue;
                                        elseif(area < da('all').min_area || area > da('all').max_area)                                            
                                            disp('Filtration of combination: area');
                                            continue;
                                        else
                                            newcand.y = pa(1);
                                            newcand.x = pa(2);
                                            wcand = [wcand; newcand];
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
