

I=double(imread('00.005263.png'));
I=im2bw(I);
%Detect connected components
[L, NUM] = bwlabeln(I);
%Obtain BBox for each CC
blobMeasurements = regionprops(L, I, 'all');
coor=blobMeasurements(:).BoundingBox;
BB_Area=[];
fr=[];
ff=[];
% calculate the for the obtained bounging boxes: filling ratio, area and form factor
% figure()
% imshow(I)
for i=1:NUM
    coor(i,:)=blobMeasurements(i).BoundingBox;
    BB_Area(i)= coor(i,3)*coor(i,4);
    fr(i)= blobMeasurements(i).Area/BB_Area(i);
    ff(i)=coor(i,3)/coor(i,4);
    %rectangle('Position',[coor(i,1),coor(i,2),coor(i,3),coor(i,4)],'EdgeColor','r','LineWidth',2 );
end
c=0;
for i=1:NUM
    if (blobMeasurements(i).Area > 930) && (blobMeasurements(i).Area < 56168)
        c=c+1;
        box(c,:)=blobMeasurements(i).BoundingBox;
        fr1(c)=fr(i);
        ff1(c)=ff(i);
        bbimage(c)=i;
        %rectangle('Position',[box(c,1),box(c,2),box(c,3),box(c,4)],'EdgeColor','r','LineWidth',2 )
    end
end
m=0;
for j=1:c
    if (fr1(j)>0.477) && (fr1(j) < 1)
        m=1+m;
        B_box(m,:)=box(j,:);
        fr2(m)=fr1(j);
        ff2(m)=ff1(j);
        bbimage1(m)=bbimage(j);
        %rectangle('Position',[B_box(m,1),B_box(m,2),B_box(m,3),B_box(m,4)],'EdgeColor','r','LineWidth',2 );
    end
end
n=0;
for t=1:m
    if (ff2(t)>0.44) && (ff2(t)<1.419)
        n=n+1;
        BB_box(n,:)=B_box(t,:);
        bbimage2(n)=bbimage1(t);
        %rectangle('Position',[BB_box(n,1),BB_box(n,2),BB_box(n,3),BB_box(n,4)],'EdgeColor','r','LineWidth',2 );
    end
end

x=0;
y=0;
% manera 1
%ImBBox = blobMeasurements(bbimage2).ConvexImage

% manera 2
x=BB_box(1);
y=BB_box(2);
w=BB_box(3);
h=BB_box(4);
ImB=I(round(y:(y+h-1)),round(x:(x+w-1)));
% figure()
% imshow(ImB)

%Correlation
addpath('templates');
a=load ('mean_train.mat');
            T=a.templates(:,:,4);
            %T=logical(T);
            ImB= imresize(ImB, size(T));
            Diff=abs(T-ImB);
            Sum=sum(sum(Diff));
            Mean=Sum/(size(Diff,1)*size(Diff,2))
            windowCandidates = [struct('x',double(0),'y',double(0),'w',double(0),'h',double(0))];
            windowCandidates(count) = [struct('x',1,'y',2,'w',3,'h',4)];
                    
            
%             Correlation=corrcoef(ImB,T);
%             diag=eye(size(Correlation));
%             Correlation=Correlation-diag;
%             C_value=max(max(Correlation));
            
%             % Find the average of the BBox
%             meanIm=mean2(ImB);
%             % Find the average of the Template
%             meanT=mean2(T);
%             %substract the average from BBox an Template
%             Imsub= ImB-meanIm;
%             Tsub= T-meanT;
%             %covariance of BBox image and Template
%             covImT=mean2(Imsub.*Tsub);
%             %Find the standard deviation of the BBox and Template
%             stdIm=std(ImB(:),1);
%             stdB=std(T(:),1);
%             Correlation=covImT./(stdIm*stdB+1)
%             if max(Correlation)>0.5
%                  if (size(BB_box,1) ~= 0)
%                     windowCandidates = [struct('x',double(0),'y',double(0),'w',double(0),'h',double(0))];
%                     for i=1:size(BB_box, 1)
%                         windowCandidates(i) = [struct('x',double(BB_box(i,1)),'y',double(BB_box(i,2)),'w',double(BB_box(i,3)),'h',double(BB_box(i,4)))];
%                     end
%                  end
%         end


%% FUNCIO
%                     % Find the average of the BBox
%                     meanIm=mean2(ImB);
%                     % Find the average of the Template
%                     meanT=mean2(T);
%                     %substract the average from BBox an Template
%                     Imsub= ImB-meanIm;
%                     Tsub= T-meanT;
%                     %covariance of BBox image and Template
%                     covImT=mean2(Imsub.*Tsub);
%                     %Find the standard deviation of the BBox and Template
%                     stdIm=std(ImB(:),1);
%                     stdB=std(T(:),1);
%                     Correlation(i,j)=covImT./(stdIm*stdB+1);
% 
% 
