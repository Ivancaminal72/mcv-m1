function [BB_box] = SegmentationCCL(mask, da, im)

%Detect connected components
[L, NUM] = bwlabeln(mask);
%Obtain BBox for each CC
blobMeasurements = regionprops(L, mask, 'all');

BB_box = [];
BB_Area=[];
fr=[];
ff=[];

% calculate the for the obtained bounging boxes: filling ratio, area and form factor
for i=1:NUM
    disp(blobMeasurements(i).BoundingBox);
    coor(i,:)=blobMeasurements(i).BoundingBox;
    BB_Area(i)= coor(i,3)*coor(i,4);
    fr(i)= blobMeasurements(i).Area/BB_Area(i);
    ff(i)=coor(i,3)/coor(i,4);
end

% Area bounig box 
c=0;
for i=1:NUM
    if (blobMeasurements(i).Area > da('all').min_area) && (blobMeasurements(i).Area < da('all').max_area)
        c=c+1;
        box(c,:)=blobMeasurements(i).BoundingBox;
        fr1(c)=fr(i);
        ff1(c)=ff(i);
    end
end

% Filling Ratio
m=0;
for j=1:c
    if (fr1(j)>da('all').fr_min) && (fr1(j) < da('all').fr_max)
        m=1+m;
        B_box(m,:)=box(j,:);
        fr2(m)=fr1(j);
        ff2(m)=ff1(j);
    end
    %rectangle('Position',[B_box(j,1),B_box(j,2),B_box(j,3),B_box(j,4)],'EdgeColor','r','LineWidth',2 );
end

% Form factor
n=0;
figure(1);
imshow(double(mask))
for t=1:m
    if (ff2(t)> da('all').ff_min) && (ff2(t)< da('all').ff_max)
        n=n+1;
        BB_box(n,:)=B_box(t,:);
        rectangle('Position',[BB_box(n,1),BB_box(n,2),BB_box(n,3),BB_box(n,4)],'EdgeColor','r','LineWidth',2 );
    end
end
waitforbuttonpress();
end